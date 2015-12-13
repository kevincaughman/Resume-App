//
//  Enums.swift
//  Resume
//
//  Created by Kevin Caughman on 6/23/15.
//  Copyright © 2015 Kevin Caughman. All rights reserved.
//

// enum for errors. New in Swift 2.0 enum as ErrorType
enum Error: ErrorType {
    case EmptyField
    case PasswordsDoNotMatch
    case InvalidEmail
    case UserNameTaken
    case IncorrectSignIn
    case InvalidPassword
}

// use extension to add text to our errors so we can display it through our errorLabel.
extension Error: CustomStringConvertible {
    var description: String {
        switch self {
        case .EmptyField: return "Please fill in all fields"
        case .PasswordsDoNotMatch: return "The passwords do not match"
        case .InvalidEmail: return "Please enter a valid email"
        case .UserNameTaken: return "The username or password is already taken"
        case .IncorrectSignIn: return "Your username or password is incorrect"
        case .InvalidPassword: return "Password must be 8 or more characters,\n and include a numeric and a capital letter"
        }
    }
}
