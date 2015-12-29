//
//  ParseModel.swift
//  Resume
//
//  Created by Kevin Caughman on 12/20/15.
//  Copyright © 2015 Kevin Caughman. All rights reserved.
//

import Foundation

class ParseModel {
    
    static func delay(seconds seconds: Double, completion:()->()) {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
        
        dispatch_after(popTime, dispatch_get_main_queue()) {
            completion()
        }
    }

    
    func loginUserAsync(email: String, password: String, completion:(success:Bool) -> Void)
    {
        
        PFUser.logInWithUsernameInBackground(email, password: password)
            { userHandler -> Void in
                
                if userHandler.1 == nil && userHandler.0 != nil
                {
                    completion(success: true)
                }
                else
                {
                    completion(success: false)
                }
        }
    }
//    
//    
//    func checkAllRequirements() throws {
//        
//        // Check to make sure none of the text fields on our sign up view are empty //
//        
//        if firstName!.isEmpty && lastName!.isEmpty && userName!.isEmpty && userEmail!.isEmpty && password!.isEmpty && confirmPassword!.isEmpty {
//            throw Error.EmptyField
//        }
//        
//        // Check for a valid email using a regular expression //
//        
//        let emailEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
//        let range = userEmail!.rangeOfString(emailEX, options:.RegularExpressionSearch)
//        let result = range != nil ? true : false
//        
//        if result == false {
//            throw Error.InvalidEmail
//        }
//        
//        // Check to make sure both password entries are the same //
//        
//        if(password! != confirmPassword!) {
//            throw Error.PasswordsDoNotMatch
//        }
//        
//        // Check for three password requirements //
//        
//        // check for capital letter
//        let capitalLetterRegEx = ".*[A-Z]+.*"
//        let textTest = NSPredicate(format: "SELF MATCHES %@", capitalLetterRegEx)
//        let capitalResult = textTest.evaluateWithObject(password!)
//        print("Capital letter: \(capitalResult)")
//        
//        // check for a number
//        let numberRegEx = ".*[0-9]+.*"
//        let textTest2 = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
//        let numberResult = textTest2.evaluateWithObject(password!)
//        print("Number included: \(numberResult)")
//        
//        // check for 8 or more characters
//        let lengthResult = password!.characters.count >= 8
//        print("Passed length: \(lengthResult)")
//        
//        if !capitalResult && !numberResult && !lengthResult {
//            throw Error.InvalidPassword
//        }
//    }

}