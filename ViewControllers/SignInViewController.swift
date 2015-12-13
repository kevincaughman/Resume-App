//
//  SignInViewController.swift
//  Resume
//
//  Created by Kevin Caughman on 6/23/15.
//  Copyright © 2015 Kevin Caughman. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    // textField variables
    @IBOutlet private weak var userName: UITextField!
    @IBOutlet private weak var password: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // delegate variables
        userName.delegate = self
        password.delegate = self
    }

    // Sign In button
    @IBAction func signInTouched(sender: UIButton) {
        // initialize SignIn model and pass in variables
        let signin = SignIn(user: userName.text!, pass: password.text!)
        
        do {
            // call signIn model function SignInUser()
            // anything under this try will execute if signInUser returns true
            try signin.signInUser()
            
            // dismiss view controller and go to MainViewController
            self.dismissViewControllerAnimated(true, completion: nil)
            
          // catches error thrown by SignInUser() if there is one
        } catch let error as Error {
            errorLabel.text = error.description
        } catch {
            errorLabel.text = "Sorry something went\n wrong please try again"
        }
        
    }
    // Dismiss keyboard if user touches the background area
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }


}
