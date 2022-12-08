//
//  SignUpViewController.swift
//  DoorDrink
//
//  Created by Samiksha Gumbhir on 12/6/22.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    private var email = ""
    private var password = ""
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Reset fields
        errorLabel.text = ""
        nameField.text = ""
        emailField.text = ""
        passwordField.text = ""
        cityField.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        // Reset fields
        errorLabel.text = ""
        nameField.text = ""
        emailField.text = ""
        passwordField.text = ""
        cityField.text = ""
    }
    

    @IBAction func signUpPressed(_ sender: UIButton) {
        
        errorLabel.text = ""
        // Email and password fields shouldn't be empty
        if let _email = emailField.text, let _pass = passwordField.text, _email != "", _pass != "" {
            email = _email
            password = _pass
        }
        else {
            errorLabel.text = "Please enter a valid email or password"
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            // Could not sign up -> Clear fields and display error message
            if let error = error {
                print(error)
                self.errorLabel.text = "There was an error while signing you up"
            }
            // Successfully signed up
            else{
                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "MapViewContollerID") as! MapViewController
                self.present(nextViewController, animated:true, completion:nil)
            }
        }
        
        // Reset fields
        nameField.text = ""
        emailField.text = ""
        passwordField.text = ""
        cityField.text = ""
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
