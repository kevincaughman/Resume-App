//
//  SignUpViewController.swift
//  Resume
//
//  Created by Kevin Caughman on 6/23/15.
//  Copyright © 2015 Kevin Caughman. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate, UIAlertViewDelegate {
    // TextField variables
    @IBOutlet private weak var firstName: UITextField!
    @IBOutlet private weak var lastName: UITextField!
    @IBOutlet private weak var userName: UITextField!
    @IBOutlet private weak var userEmail: UITextField!
    @IBOutlet private weak var password: UITextField!
    @IBOutlet private weak var confirmPassword: UITextField!
    // Label to display an error below textFields
    @IBOutlet private weak var errorLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Delegating our variables
        firstName.delegate = self
        lastName.delegate = self
        userName.delegate = self
        userEmail.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
    
    }

    // SignUp button
    @IBAction func signUpTouched(sender: UIButton) {
        // Clear label each time the button is clicked to clear previous errors.
        errorLabel.text = ""
        
        // Initialize SignUp Model and pass in variables
        let signup = SignUp(fName: firstName.text!, lName: lastName.text!, uName: userName.text!, email: userEmail.text!, pass: password.text!, confirmPass: confirmPassword.text!)
        
        // perform try catch below to sign up user
        do {
            // call signUp model function SignUpUser()
            // anything under this try will execute if signUpUser returns true
            try signup.signUpUser()
            
            // Display an alert view showing successful signup
            let alert = signUpSeccuessAlert()
            presentViewController(alert, animated: true, completion: nil)
            
           // catches the error thrown by SignUpUser() if there is one
        } catch let error as Error {
            errorLabel.text = error.description
        } catch { errorLabel.text = "Sorry something went wrong please try again"
            
        }
        
    }
    // dismiss keyboard if user touches the background area
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    //Mark: This will take the user straight to the MainViewController since a session is created at signup.
    // creates and returns an alert view to display when signup is successful
    func signUpSeccuessAlert() -> UIAlertController {
        let alertview = UIAlertController(title: "Sign up Successful", message: "Now you can log in for complete access", preferredStyle: .Alert)
        alertview.addAction(UIAlertAction(title: "Login", style: .Default, handler: { (alertAction) -> Void in self.dismissViewControllerAnimated(true, completion: nil)
    }))
        alertview.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        return alertview
    }
    
    //Mark: Alternate to above code. This will take the user to the Sign in screen.
    /*func signUpSeccuessAlert() -> UIAlertController {
        let alertview = UIAlertController(title: "Sign up Successful", message: "Now you can log in for complete access", preferredStyle: .Alert)
        alertview.addAction(UIAlertAction(title: "Login", style: .Default, handler: { (alertAction) -> Void in self.dismissViewControllerAnimated(true, completion: nil)
    }))
        alertview.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        return alertview
    }*/

}
