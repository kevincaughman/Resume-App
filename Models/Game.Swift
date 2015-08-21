//
//  Game.swift
//  My Resume
//
//  Created by Kevin Caughman on 7/12/15.
//  Copyright © 2015 Kevin Caughman. All rights reserved.
//

class Game {
    
    private var resultText = String()
    private var appChoice = String()
    private var playerPreviousChoice = ""
    private var winner = String()
    private var choices = (String(), String())
    private let rpsEngine = RPSEngine()
    
    private var getChoice: String {
        get {
            switch playerPreviousChoice {
                case "Rock":
                    return "R"
                case "Paper":
                    return "P"
                case "Scissors":
                    return "S"
            default:
                return playerPreviousChoice
            }
        } set {
            switch "\(newValue)" {
            case "R":
                appChoice = "Rock"
            case "P":
                appChoice = "Paper"
            case "S":
                appChoice = "Scissors"
            default:
                appChoice = "Rock"
            }
        }
    }
    
    func getGameWinner(playerChoice: String, ai: Bool) -> String {
        
        getChoice = rpsEngine.getMove(getChoice, aiOn: ai)
        choices = (appChoice, playerChoice)
        playerPreviousChoice = playerChoice
        
        switch choices {
            case ("Rock", "Paper"):
                resultText = "The app chose \(appChoice),\n You win!"
                winner = "player"
            case ("Rock", "Scissors"):
                resultText = "The app chose \(appChoice),\n The app wins!"
                winner = "app"
            case ("Paper", "Rock"):
                resultText = "The app chose \(appChoice),\n The app wins!"
                winner = "app"
            case ("Paper", "Scissors"):
                resultText = "The app chose \(appChoice),\n You win!"
                winner = "player"
            case ("Scissors", "Rock"):
                resultText = "The app chose \(appChoice),\n You win!"
                winner = "player"
            case ("Scissors", "Paper"):
                resultText = "The app chose \(appChoice),\n The app wins!"
                winner = "app"
        default:
            resultText = "The app chose \(appChoice),\n It's a tie!"
            winner = "tie"
        }
        print("winner = \(winner)")
        return resultText
    }
    
    func addPointToWinner(var app: Int, var player: Int) -> (newAppScore: Int, newPlayerScore: Int) {
        
        switch winner {
            case "player":
                player++
            case "app":
                app++
        default:
            return (app, player)
        }
        return (app, player)
    }

}
