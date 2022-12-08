//
//  ViewController.swift
//  GumbhirSamikshaHW3
//
//  Created by Samiksha Gumbhir on 9/11/22.
//

import UIKit

class ViewController: UIViewController {

    var name: String?
    var textval: String?

    @IBOutlet weak var TextLabel: UILabel!
    
    @IBOutlet weak var Image2: UIImageView!
    @IBOutlet weak var Image1: UIImageView!
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var ResetOutlet: UIButton!
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var NameInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        QuestionLabel.accessibilityIdentifier = HW3AccessibilityIdentifiers.questionLabel
        NameInput.accessibilityIdentifier = HW3AccessibilityIdentifiers.answerTextField
        TextLabel.accessibilityIdentifier = HW3AccessibilityIdentifiers.messageLabel
        Button1.accessibilityIdentifier = HW3AccessibilityIdentifiers.optionButton1
        Button2.accessibilityIdentifier = HW3AccessibilityIdentifiers.optionButton2
        ResetOutlet.accessibilityIdentifier = HW3AccessibilityIdentifiers.resetButton
        Image1.accessibilityIdentifier = HW3AccessibilityIdentifiers.answerImageView1
        Image2.accessibilityIdentifier = HW3AccessibilityIdentifiers.answerImageView2
        NameInput.returnKeyType = UIReturnKeyType.done
        NameInput.becomeFirstResponder()
        
    }

    
    @IBAction func ResignKeyboard(_ sender: UIButton) {
        NameInput.resignFirstResponder()
    }
    
    @IBAction func NameInputReturnKey(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func CatButton(_ sender: UIButton) {
        if NameInput.text != "" {
            name = NameInput.text
        }
        if let currname = name{
            TextLabel.text  = "\(currname), I purr you"
        }
        else {
            TextLabel.text  = "I purr you"
        }
    }
    

    @IBAction func DogButton(_ sender: UIButton) {
        if NameInput.text != "" {
            name = NameInput.text
        }
        if let currname = name{
            TextLabel.text  = "\(currname), I woof you"
        }
        else {
            TextLabel.text  = "I woof you"
        }
    }
    
    @IBAction func ResetButton(_ sender: Any) {
        TextLabel.text  = ""
        NameInput.text = ""
        name = nil
    }
    
}

