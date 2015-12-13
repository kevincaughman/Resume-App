//
//  Game.swift
//  Resume
//
//  Created by Kevin Caughman on 7/25/15.
//  Copyright © 2015 Kevin Caughman. All rights reserved.
//

class Game {
    
    //MARK: - Stored Properties
    private var resultText = String()
    private var appChoice = String()
    private var playerPreviousChoice = ""
    private var winner = String()
    private var choices = (String(), String())
    private let rpsEngine = RPSEngine()
    
    private var translateChoice: String {
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
            switch newValue {
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

    
    //MARK: - Primary Methods
    func getGameWinner(playerChoice: String, aiOn: Bool) -> String {
        
        translateChoice = rpsEngine.getMove(translateChoice, aiOn: aiOn)

        choices = (appChoice, playerChoice)
        
        playerPreviousChoice = playerChoice
        
        let playerWon = "The app chose \(appChoice),\n You win!"
        let appWon = "The app chose \(appChoice),\n the App wins!"
        
        switch choices {
            case ("Rock", "Paper"):
                resultText = playerWon
                winner = "player"
            case ("Rock", "Scissors"):
                resultText = appWon
                winner = "app"
            case ("Paper", "Rock"):
                resultText = appWon
                winner = "app"
            case ("Paper", "Scissors"):
                resultText = playerWon
                winner = "player"
            case ("Scissors", "Rock"):
                resultText = playerWon
                winner = "player"
            case ("Scissors", "Paper"):
                resultText = appWon
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
    
    //    func calculateAppsChoice() -> String {
    //        let random = RandomNumber()
    //
    //        switch random.num {
    //            case 0...0.33:
    //                appChoiceText = "Rock"
    //            case 0.34...0.66:
    //                appChoiceText = "Paper"
    //            case 0.67...0.99:
    //                appChoiceText = "Scissors"
    //        default:
    //            break
    //        }
    //        print("\(random.num) = \(appChoiceText)")
    //        return appChoiceText
    //    }
    
}
