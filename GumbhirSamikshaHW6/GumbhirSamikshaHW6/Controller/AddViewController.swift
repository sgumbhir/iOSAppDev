//
//  AddNewController.swift
//  GumbhirSamikshaHW6
//
//  Created by Samiksha Gumbhir on 10/21/22.
//

import UIKit

class AddViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    

    @IBOutlet weak var isFavorite: UISwitch!
    @IBOutlet weak var addAnswer: UITextField!
    @IBOutlet weak var addQuestion: UITextView!
    var answerVal = ""
    var questionVal = ""
    typealias AddCompletionHandler = (String?, String?, Bool) -> Void
    var completionHandler: AddCompletionHandler?
    public var editingExisting: Flashcard?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addQuestion.delegate = self
        editingExisting = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        addQuestion.returnKeyType = UIReturnKeyType.next
        addAnswer.returnKeyType = UIReturnKeyType.done
        addQuestion.becomeFirstResponder()
        saveButton.isEnabled = false
    }
    
    @IBAction func resignButton(_ sender: UIButton) {
        if addQuestion.isFirstResponder {
            addQuestion.resignFirstResponder()
        }
        if addAnswer.isFirstResponder {
            addAnswer.resignFirstResponder()
        }
    }
    
    @IBAction func pressSave(_ sender: UIBarButtonItem) {
        
        if let question = addQuestion.text, let answer = addAnswer.text
        {
            questionVal = question
            answerVal = answer
            if !FlashcardsModel.sharedInstance.checkAskedQuestion(potentialQuestion: question){
                if let completionHandler = self.completionHandler{
                    completionHandler(question, answer, isFavorite.isOn)
                }
                dismiss(animated: true)
            }
            else{
                addAnswer.text = nil
                addQuestion.text = nil
                let alertController = UIAlertController(title: "Warning!", message: "The question you have entered already exists. Try a new question.",
                preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                saveButton.isEnabled = false
            }
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        saveButton.isEnabled = !addQuestion.text!.isEmpty && !addAnswer.text!.isEmpty
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField)
        if textField == addAnswer {
            addAnswer.resignFirstResponder()

            if let answer = addAnswer.text {
                answerVal = answer
            }

        }
       return true
   }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            addQuestion.resignFirstResponder()
            addAnswer.becomeFirstResponder()
            if let quest = addQuestion.text{
                questionVal = quest
            }
        }
        
        return true
    }
    

    @IBAction func pressedCancel(_ sender: Any) {
        if let completionHandler = self.completionHandler{
            completionHandler(nil, nil, isFavorite.isOn)
            
        }
        addAnswer.text = nil
        addQuestion.text = nil
        dismiss(animated: true)
    }
}
