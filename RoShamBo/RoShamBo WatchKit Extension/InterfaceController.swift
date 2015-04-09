//
//  InterfaceController.swift
//  RoShamBo WatchKit Extension
//
//  Created by Brian Batchelder on 4/8/15.
//  Copyright (c) 2015 PDX-iOS. All rights reserved.
//

import WatchKit
import Foundation
import RoShamBoKit

class InterfaceController: WKInterfaceController {

    @IBOutlet var rockButton : WKInterfaceButton!
    @IBOutlet var paperButton : WKInterfaceButton!
    @IBOutlet var scissorsButton : WKInterfaceButton!
    @IBOutlet var lizardButton : WKInterfaceButton!
    @IBOutlet var spockButton : WKInterfaceButton!
    
    @IBOutlet var chooseLabel : WKInterfaceLabel!
    
    @IBOutlet var resultsSeparator : WKInterfaceSeparator!
    @IBOutlet var winnerButton : WKInterfaceButton!
    @IBOutlet var verbLabel : WKInterfaceLabel!
    @IBOutlet var loserButton : WKInterfaceButton!
    @IBOutlet var resultsLabel : WKInterfaceLabel!
    
    var activeButton : WKInterfaceButton!
    var activeButtonActiveBackground : String!
    var activeButtonInactiveBackground : String!
    
    var playerChoice : Choice!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        resultsSeparator.setHidden(true)
        winnerButton.setHidden(true)
        verbLabel.setHidden(true)
        loserButton.setHidden(true)
        resultsLabel.setHidden(true)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func rockPressed() {
        playerChoice = Choice.Rock
        playGame(rockButton)
    }

    @IBAction func paperPressed() {
        playerChoice = Choice.Paper
        playGame(paperButton)
    }
    
    @IBAction func scissorsPressed() {
        playerChoice = Choice.Scissors
        playGame(scissorsButton)
    }
    
    @IBAction func lizardPressed() {
        playerChoice = Choice.Lizard
        playGame(lizardButton)
    }
    
    @IBAction func spockPressed() {
        playerChoice = Choice.Spock
        playGame(spockButton)
    }

    func playGame(myButton : WKInterfaceButton) {
        activeButtonActiveBackground = "\(playerChoice.name)-highlighted.png"
        myButton.setBackgroundImageNamed(activeButtonActiveBackground)
        if ((activeButton) != nil) {
            activeButton.setBackgroundImageNamed(activeButtonInactiveBackground)
        }
        activeButton = myButton;
        activeButtonInactiveBackground = "\(playerChoice.name).png"

        chooseLabel.setHidden(true)
        
        let compChoice = Choice.random()
        
        var results: String
        let r = Game(player1: playerChoice!, player2: compChoice).play()

        var winnerImageName : String
        var loserImageName : String
        
        if r.draw {
            winnerImageName = playerChoice.name
            loserImageName = compChoice.name
            verbLabel.setText("==")
            results = "It's a draw. Try again!"
        } else {
            let playerWon = (r.winner == playerChoice!)
            
            if playerWon {
                winnerImageName = "\(r.winner.name)-highlighted"
                loserImageName = r.loser.name
            } else {
                winnerImageName = r.winner.name
                loserImageName = "\(r.loser.name)-highlighted"
            }
            verbLabel.setText(r.winner.verb(r.loser))
            results = playerWon ? "You win!" : "You lose!"
        }
                
        winnerButton.setBackgroundImageNamed("\(winnerImageName).png")
        loserButton.setBackgroundImageNamed("\(loserImageName).png")
        resultsLabel.setText(results)
        
        resultsSeparator.setHidden(false)
        winnerButton.setHidden(false)
        verbLabel.setHidden(false)
        loserButton.setHidden(false)
        resultsLabel.setHidden(false)
        
    }

}
