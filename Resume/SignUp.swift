//
//  SignUp.swift
//  Resume
//
//  Created by Kevin Caughman on 6/23/15.
//  Copyright © 2015 Kevin Caughman. All rights reserved.
//

class SignUp: NSObject {
    
    // declare variables as optional Strings, optional means String may return nil.
    // optionals need unwrapped by adding a ! to the end.
    var firstName: String?
    var lastName: String?
    var userName: String?
    var userEmail: String?
    var password: String?
    var confirmPassword: String?
    
    // initialize each variable for use below. This is done by initializing this SignUp model in a given view controller and passing in the required variables.
    init(fName: String, lName: String, uName: String, email: String, pass: String, confirmPass: String){
        self.firstName = fName
        self.lastName = lName
        self.userName = uName
        self.userEmail = email
        self.password = pass
        self.confirmPassword = confirmPass
    }

    func checkAllRequirements() throws {
        
        // Check to make sure none of the text fields on our sign up view are empty //
        
        if firstName!.isEmpty && lastName!.isEmpty && userName!.isEmpty && userEmail!.isEmpty && password!.isEmpty && confirmPassword!.isEmpty {
            throw Error.EmptyField
        }
        
        // Check for a valid email using a regular expression //
        
        let emailEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = userEmail!.rangeOfString(emailEX, options:.RegularExpressionSearch)
        let result = range != nil ? true : false
        
        if result == false {
            throw Error.InvalidEmail
        }
        
        // Check to make sure both password entries are the same //
        
        if(password! != confirmPassword!) {
            throw Error.PasswordsDoNotMatch
        }
        
        // Check for three password requirements //
        
        // check for capital letter
        let capitalLetterRegEx = ".*[A-Z]+.*"
        let textTest = NSPredicate(format: "SELF MATCHES %@", capitalLetterRegEx)
        let capitalResult = textTest.evaluateWithObject(password!)
        print("Capital letter: \(capitalResult)")
        
        // check for a number
        let numberRegEx = ".*[0-9]+.*"
        let textTest2 = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        let numberResult = textTest2.evaluateWithObject(password!)
        print("Number included: \(numberResult)")
        
        // check for 8 or more characters
        let lengthResult = password!.characters.count >= 8
        print("Passed length: \(lengthResult)")
        
        if !capitalResult && !numberResult && !lengthResult {
            throw Error.InvalidPassword
        }
    }
    // store user in Parse database and create session as current user
    func saveUserAsync(completion:(result: PFUser?, success: Bool) -> Void)
    {
        let user = PFUser()     // initialize variable as PFUser
        
        user["FirstName"] = firstName!       //**
        user["LastName"] = lastName!        // user will take each field and add them to your object
        user.username = userName!          // Use PFUser pre made fields username, email, or password.
        user.email = userEmail!           // To create a custom field name use [""] to decalre the name.
        user.password = password!        //**
        
        user.signUpInBackgroundWithBlock({(success: Bool, error: NSError?) -> Void in
            
            if success {
                completion(result: PFUser.currentUser()!, success: true)
            } else {
                completion(result: nil, success: false)
            }
        })
    
    }

}
