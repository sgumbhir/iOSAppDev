//
//  EditViewController.swift
//  GumbhirSamikshaHW6
//
//  Created by Samiksha Gumbhir on 10/22/22.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var addAnswer: UITextField!
    @IBOutlet weak var addQuestion: UITextView!
    @IBOutlet weak var isFavorite: UISwitch!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    typealias EditCompletionHandler = (String?, String?, Bool) -> Void
    var completionHandler: EditCompletionHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addQuestion.returnKeyType = UIReturnKeyType.next
        addAnswer.returnKeyType = UIReturnKeyType.done
        addQuestion.becomeFirstResponder()
    }
    
    @IBAction func pressedSave(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func pressedCancel(_ sender: UIBarButtonItem) {
    }
}
