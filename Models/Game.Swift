//
//  Game.swift
//  Resume
//
//  Created by Kevin Caughman on 7/25/15.
//  Copyright © 2015 Kevin Caughman. All rights reserved.
//

class Game {
    
    private var resultText = String()
    private var appChoiceText = String()
    private var winner = String()
    private var appWins = Int()
    private var playerWIns = Int()
    
    private struct RandomNumber {
        var num = drand48()
    }
    
    func getGameWinner(playerChoice: String) -> String {
        
        let appChoice = calculateAppsChoice()
        let choices = (appChoice, playerChoice)
        let playerWon = "The appChose \(appChoice),\n You win!"
        let appWon = "The app chose \(appChoice),\n App wins!"
        
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
    
    func calculateAppsChoice() -> String {
        let random = RandomNumber()
        
        switch random.num {
            case 0...0.33:
                appChoiceText = "Rock"
            case 0.34...0.66:
                appChoiceText = "Paper"
            case 0.67...0.99:
                appChoiceText = "Scissors"
        default:
            break
        }
        print("\(random.num) = \(appChoiceText)")
        return appChoiceText
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
