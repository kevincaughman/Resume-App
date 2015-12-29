//
//  TabBarViewController.swift
//  Resume
//
//  Created by Kevin Caughman on 12/20/15.
//  Copyright © 2015 Kevin Caughman. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    private var user: PFUser?

    override func viewDidLoad() {
        super.viewDidLoad()
        //let currentUser = user.currentUser()

        if PFUser.currentUser() == nil {
            showSignInView()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showSignInView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signInView = storyboard.instantiateViewControllerWithIdentifier("SignInView")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = signInView
    }

}
