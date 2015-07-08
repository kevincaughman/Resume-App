//
//  ViewController.swift
//  Resume
//
//  Created by Kevin Caughman on 6/7/15.
//  Copyright (c) 2015 Kevin Caughman. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        // use PFUser to see if there is a current user signed in
        if PFUser.currentUser() != nil {
            //do something in main view controller
        } else {
            // take user to SignInViewController through a custom segue
            self.performSegueWithIdentifier("goSignIn", sender: self)
        }
        
    }
    // Log out button
    @IBAction func logOutUser(sender: UIButton) {
        // log current user out and end session
        PFUser.logOut()
        
        // take user back to SignInViewController through a custom segue
        self.performSegueWithIdentifier("goSignIn", sender: self)
    }
    

}

