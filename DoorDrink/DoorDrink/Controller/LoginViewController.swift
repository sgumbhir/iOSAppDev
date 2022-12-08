//
//  LoginViewController.swift
//  DoorDrink
//
//  Created by Samiksha Gumbhir on 12/6/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {
    
    private var password: String = ""
    private var email: String = ""
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Reset fields
        errorLabel.text = ""
        emailField.text = ""
        passwordField.text = ""

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        // Reset fields
        errorLabel.text = ""
        emailField.text = ""
        passwordField.text = ""

    }
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        errorLabel.text = ""
        // Email and password fields shouldn't be empty
        if let _email = emailField.text, let _pass = passwordField.text, _email != "", _pass != "" {
            email = _email
            password = _pass
        }
        // Email or password not entered
        else{
            errorLabel.text = "Please enter a valid email or password"
            return
        }
        
        Auth.auth().signIn(withEmail: self.email, password: self.password) { authResult, error in
            // Could not sign in -> Clear fields and display error message
            if let error = error {
                print(error)
                self.errorLabel.text = "The email or password you entered is not correct"
            }
            // Successfully signed in
            else{
                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "MapViewContollerID") as! MapViewController
                self.present(nextViewController, animated:true, completion:nil)
            }

        }
        
        // Reset fields
        emailField.text = ""
        passwordField.text = ""

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
