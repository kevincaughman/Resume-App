//
//  ViewController.swift
//  Resume
//
//  Created by Kevin Caughman on 6/7/15.
//  Copyright (c) 2015 Kevin Caughman. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate {

    // MARK - IBOutlets
    @IBOutlet private weak var playerChoicetxt: UITextField!
    @IBOutlet private weak var gamePickerView: UIPickerView!
    @IBOutlet private weak var playerWins: UILabel!
    @IBOutlet private weak var appWins: UILabel!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var gameResultsLabel: UILabel!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet weak var gameAISwitch: UISwitch!
    
    // MARK: - MainVC Properties
    let game = Game()
    private let gameChoices = ["Rock", "Paper", "Scissors"]
    private var getAppScore: Int {
        get {
            return NSNumberFormatter().numberFromString(appWins.text!)!.integerValue
        }
        set {
            appWins.text = "\(newValue)"
        }
    }
    private var getPlayerScore: Int {
        get {
            return NSNumberFormatter().numberFromString(playerWins.text!)!.integerValue
        }
        set {
            playerWins.text = "\(newValue)"
        }
    }
    
    //MARK: - Primary View Functions/Actions
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        // use PFUser to see if there is a current user signed in
        if PFUser.currentUser() == nil {
            // take user to SignInViewController through a custom segue
            self.performSegueWithIdentifier("goSignIn", sender: self)
        }
        
        userNameLabel.text = "Welcome \(PFUser.currentUser()!.username!), to my"
        gamePickerView.delegate = self
        playerChoicetxt.delegate = self
    }
    
    @IBAction func playBtnTouched(sender: UIButton) {
        
        var gameSwitchPosition: Bool { return gameAISwitch.on }
        
        gameResultsLabel.text = game.getGameWinner(playerChoicetxt.text!, aiOn: gameSwitchPosition)
        
        (getAppScore, getPlayerScore) = game.addPointToWinner(getAppScore, player: getPlayerScore)
    }
    
    @IBAction func logOutUser(sender: UIButton) {
        // log current user out and end session
        PFUser.logOut()
        
        // take user back to SignInViewController through a custom segue
        self.performSegueWithIdentifier("goSignIn", sender: self)
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        gamePickerView.hidden = false
        return false
    }
    
    //MARK: - PickerView Functions
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        playerChoicetxt.text = gameChoices[row]
        gamePickerView.hidden = true
        
        if playerChoicetxt.text != "-SELECT-" {
            playButton.enabled = true
            playButton.alpha = 1
        } else {
            playButton.enabled = false
            playButton.alpha = 0.5
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gameChoices[row]
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gameChoices.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
}

