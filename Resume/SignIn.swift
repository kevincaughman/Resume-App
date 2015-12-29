//
//  SignIn.swift
//  Resume
//
//  Created by Kevin Caughman on 7/4/15.
//  Copyright © 2015 Kevin Caughman. All rights reserved.
//

typealias userHandler = (user: PFUser?, error: NSError?)

class SignIn {

    // Check to make sure none of the text fields on our sign up view are empty
    static func hasEmptyFields(userName: String, password: String) -> Bool {
        if userName.isEmpty || password.isEmpty {
            return true
        }
        return false
    }
    
    ////////// Video V8 Method ///////////////////

    // use logInWithUsername method to log in
    static func loginUserAsync(userName: String, password: String, completion:(success:Bool) -> Void)
    {
        PFUser.logInWithUsernameInBackground(userName, password: password)
            { (user: PFUser?, error: NSError?) -> Void in
                
                if error == nil {
                    completion(success: true)
                }
                else {
                    completion(success: false)
                }
        }
    }
}
    /////////// end method ////////////////////
    
//    func checkUserCredentials() -> Bool {
//        try! PFUser.logInWithUsername(userName!, password: password!)
//        // if log in is successful currentUser will be set and not nil
//        if (PFUser.currentUser() != nil) {
//            return true
//        }
//        return false
//    }

