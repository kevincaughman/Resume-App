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
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // delegate variables
        userName.delegate = self
        password.delegate = self
    }

    // Sign In button
    @IBAction func signInTouched(sender: UIButton) {
        
        ///////////////////////// Video V8 Login Async ///////////////
        if SignIn.hasEmptyFields(userName.text!, password: password.text!) {
            self.errorLabel.text = Error.IncorrectSignIn.description
            return
        }
        
        activityIndicator.startAnimating()
        activityLabel.text = "Logging In Now..."
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0))
            {
                SignIn.loginUserAsync(self.userName.text!, password: self.password.text!, completion:
                    { (success: Bool) -> Void in
                        //update UI
                        if success
                        {
                            dispatch_async(dispatch_get_main_queue())
                            {
                                ParseModel.delay(seconds: 2, completion: {
                                    print("Login successful")
                                    self.activityLabel.text = "Login Successful"
                                    ParseModel.delay(seconds: 1.5, completion:
                                    {
                                        self.showHomeView()
                                    })
                                })
                            }
                        }
                        else
                        {
                            dispatch_async(dispatch_get_main_queue())
                                {
                                    self.activityIndicator.stopAnimating()
                                    self.userName.resignFirstResponder()
                                    self.activityLabel.text = ""
                                    self.errorLabel.text = Error.IncorrectSignIn.description
                            }
                        }
                })
        }
        
        
        //////// end async ////////////
        
        //// synchronous ///////
        // initialize SignIn model and pass in variables
//        let signin = SignIn(user: userName.text!, pass: password.text!)
//        
//        do {
//            // call signIn model function SignInUser()
//            // anything under this try will execute if signInUser returns true
//            try signin.signInUser()
//            
//            // dismiss view controller and go to MainViewController
//            self.dismissViewControllerAnimated(true, completion: nil)
//            
//          // catches error thrown by SignInUser() if there is one
//        } catch let error as Error {
//            errorLabel.text = error.description
//        } catch {
//            errorLabel.text = "Sorry something went\n wrong please try again"
//        }
        
    }
    // Dismiss keyboard if user touches the background area
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func delay(seconds seconds: Double, completion:()->()) {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
        
        dispatch_after(popTime, dispatch_get_main_queue()) {
            completion()
        }
    }
    
    func showHomeView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let HomeView = storyboard.instantiateViewControllerWithIdentifier("HomeView")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = HomeView
    }


}
