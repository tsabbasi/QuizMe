//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    // global variables
    
    var currentTrivia = generateTrivia()
    
    
    let questionsPerRound = triviaCollection.count
    var questionsAsked = 0
    var correctQuestions = 0
    
    var gameSound: SystemSoundID = 0
    
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var resultField: UILabel!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        // Start game
        playGameStartSound()
        playAgainButton.hidden = true
        questionField.text = currentTrivia.question
        displayOptions()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func displayOptions() {
        option1Button.setTitle(currentTrivia.options[0], forState: .Normal)
        option2Button.setTitle(currentTrivia.options[1], forState: .Normal)
        option3Button.setTitle(currentTrivia.options[2], forState: .Normal)
        option4Button.setTitle(currentTrivia.options[3], forState: .Normal)
    }
    
    func displayScore() { // unneccesary function -> can be combined with scoring logic (when calculated)
        // Hide the answer buttons
        option1Button.hidden = true
        option2Button.hidden = true
        option3Button.hidden = true
        option4Button.hidden = true
        
        
        // Display play again button
        playAgainButton.hidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }

    
    @IBAction func checkAnswer(sender: UIButton) {
        
        // Increment the questions asked counter
        questionsAsked += 1
        
        // Set correctAnswer to the current Trivia Set's answer
        let correctAnswer = currentTrivia.answer
        
        
        // Check if selected option matches the answer
        if (sender === option1Button &&  option1Button.currentTitle == correctAnswer) ||
            (sender === option2Button && option2Button.currentTitle == correctAnswer) ||
            (sender === option3Button && option3Button.currentTitle == correctAnswer) ||
            (sender === option4Button && option4Button.currentTitle == correctAnswer) {
            
            correctQuestions += 1
            
            resultField.text = "Correct!"
            
        } else {
            resultField.text = "Sorry, wrong answer!"
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            resultField.text = ""
            displayScore()
        } else {
            // Continue game
            
            currentTrivia = generateTrivia()
            questionField.text = currentTrivia.question
            resultField.text = ""
            displayOptions()
            playAgainButton.hidden = true
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        option1Button.hidden = false
        option2Button.hidden = false
        option3Button.hidden = false
        option4Button.hidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.nextRound()
        }
    }
    
    func loadGameStartSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("GameSound", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}

