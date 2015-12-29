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
        
        let signup = SignUp(fName: firstName.text!, lName: lastName.text!, uName: userName.text!, email: userEmail.text!, pass: password.text!, confirmPass: confirmPassword.text!)
        
        //////// Async Sign Up function ///////////
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0))
        {
            do {
                try signup.checkAllRequirements()
                
                signup.saveUserAsync({ (result, success) -> Void in
                    if success {
                        let alert = self.signUpSeccuessAlert()
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                })
                
            } catch let error as Error {
                dispatch_async(dispatch_get_main_queue()) { self.errorLabel.text = error.description }
            } catch {
                dispatch_async(dispatch_get_main_queue()) { self.errorLabel.text = "Sorry something went wrong please try again" }
            }
        }
        ////// End Async //////////
    }
    
    // dismiss keyboard if user touches the background area
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // creates and returns an alert view to display when signup is successful
    func signUpSeccuessAlert() -> UIAlertController {
        let alertview = UIAlertController(title: "Sign Up Successful", message: "Now you can Login for complete access", preferredStyle: .Alert)
        alertview.addAction(UIAlertAction(title: "Login", style: .Default, handler: { (alertAction) -> Void in self.dismissViewControllerAnimated(true, completion: nil)
    }))
        alertview.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        return alertview
    }
    
    @IBAction func alreadyAUserBtnTouched(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
