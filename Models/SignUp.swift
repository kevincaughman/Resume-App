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
    
    // this will call each function below checking for errors during sign up and return true if all of our error checks return true or throws a specific error based on the specific function.
    func signUpUser() throws -> Bool {
        
        // when using throws above you will write guard the function name then else with an error that is thrown if your function returns false. Each error below is called from our Enums model.
        guard hasEmptyFields() else {
            throw Error.EmptyField 
        }
        
        guard isValidEmail() else {
            throw Error.InvalidEmail
        }
        
        guard validatePasswordsMatch() else {
            throw Error.PasswordsDoNotMatch
        }
        
        guard checkPasswordSufficientComplexity() else {
            throw Error.InvalidPassword
        }
        
        guard storeSuccessfulSignUp() else {
            throw Error.UserNameTaken
        }
        return true
    }
    // Check to make sure none of the text fields on our sign up view are empty
    func hasEmptyFields() -> Bool {
        if !firstName!.isEmpty && !lastName!.isEmpty && !userName!.isEmpty && !userEmail!.isEmpty && !password!.isEmpty && !confirmPassword!.isEmpty {
            return true
        }
        return false
    }
    // Check for a valid email using a regular expression
    func isValidEmail() -> Bool {
        
        let emailEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = userEmail!.rangeOfString(emailEX, options:.RegularExpressionSearch)
        let result = range != nil ? true : false
        return result
    }
    // Check to make sure both password entries are the same
    func validatePasswordsMatch() -> Bool {
        if(password! == confirmPassword!) {
            return true
        }
        return false
    }
    // Check for three password requirements
    func checkPasswordSufficientComplexity() -> Bool {
        
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
        
        return capitalResult && numberResult && lengthResult
        
    }
    // store user in Parse database and create session as current user
    func storeSuccessfulSignUp() -> Bool {
        
        // declare variable for our boolean result
        var success = false
        // initialize variable as PFUser
        let user = PFUser()
        
        /* assign columns by calling user and use PFUser pre made fields username, email, or password. To create a custom field name use [""] to decalre the name. Then assign the variables that will be stored under that field */
        user["FirstName"] = firstName!
        user["LastName"] = lastName!
        user.username = userName!
        user.email = userEmail!
        user.password = password!
        
        // call user with Parse's signUp method to store records in the User table
        user.signUp()
        
        // use isNew method to make sure signUp is successful.
        success = user.isNew
        
        return success
    
    }
    
    
    
}
