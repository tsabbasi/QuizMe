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
    
    // Tracking variables
    var counter = 15
    let questionsPerRound = triviaCollection.count
    var questionsAsked = 0
    var correctAnswers = 0
    
    
    // Class Variables
    var timer = NSTimer()
    var currentTrivia = generateTrivia()
    var gameSounds = GameSoundModel()
  
    
    // Outlets from storyboard
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var resultField: UILabel!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var showAnswerButton: UIButton!
    @IBOutlet weak var displayScoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Prep
        gameSounds.loadCorrectAnswerSound()
        gameSounds.loadIncorrectAnswerSound()
        gameSounds.loadGameOverSound()
        gameSounds.loadWinnerSound()
        
        // Start game
        self.showNextQuestion()
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    @IBAction func checkAnswer(sender: UIButton) {
        
        // Increment the questions asked counter
        questionsAsked += 1
        
        // Set correctAnswer to the current Trivia Set's answer
        let correctAnswer = currentTrivia.answer
        
        resetTimer()
        
        // Check if selected option matches the answer
        if (sender === option1Button &&  option1Button.currentTitle == correctAnswer) ||
            (sender === option2Button && option2Button.currentTitle == correctAnswer) ||
            (sender === option3Button && option3Button.currentTitle == correctAnswer) ||
            (sender === option4Button && option4Button.currentTitle == correctAnswer) {
            
            // Correct Answer
            gameSounds.playCorrectAnswerSound()
            correctAnswers += 1
            resultField.textColor = UIColor.init(red: 21/255.0, green: 147/255.0, blue: 135/255.0, alpha: 1.0)
            resultField.text = "Correct!"
            showAnswerButton.hidden = true
            
        } else {
            
            // Incorrect Answer
            gameSounds.playInorrectAnswerSound()
            resultField.textColor = UIColor.init(red: 253/255.0, green: 162/255.0, blue: 104/255.0, alpha: 1.0)
            resultField.text = "Uh oh, wrong answer!"
            timerLabel.hidden = true
            showAnswerButton.hidden = false
            hideOptionButtons(true)
        }
    }
    
    
    
    // This function allows user to view answer if they answered incorrectly (Optional)
    
    @IBAction func showAnswer() {
        
        showAnswerButton.hidden = true
        let options: [UIButton] = [option1Button, option2Button, option3Button, option4Button]
        
        for option in options {
            
            option.hidden = false
            option.highlighted = true
            
            if option.currentTitle == currentTrivia.answer {
                
                resultField.text = "The correct answer was:"
                option.highlighted = false
                option.selected = true
            }
        }
    }
    
    
    
    // This function handles continuation of the game
    
    @IBAction func showNextQuestion() {
        
        if questionsAsked == questionsPerRound {
            
            // Game is over
            resultField.text = ""
            nextQuestionButton.hidden = true
            timerLabel.hidden = true
            displayScore()
            
        } else {
            
            // Continue game
            currentTrivia = generateTrivia()
            questionField.text = currentTrivia.question
            resultField.text = ""
            displayOptions()
            playAgainButton.hidden = true
            showAnswerButton.hidden = true
            startTimer()
        }
    }
    
    
    
    // This function resets all game settings and starts a new round automatically
    
    @IBAction func playAgain() {
        
        // resetting display settings
        hideOptionButtons(false)
        displayScoreLabel.text = ""
        questionField.hidden = false
        nextQuestionButton.hidden = false
        
        // resetting tracking settings along w/ timer
        questionsAsked = 0
        correctAnswers = 0
        resetTimer()
        
        // starting new game
        self.showNextQuestion()
    }
    
   
    
    func startTimer() {
        
        timerLabel.hidden = false
        timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    
    
    // This function acts as a counter — utilized by the startTimer function above
    
    func timerAction() {
        
        if (counter > 0) {
            
            // There is still time! Keep Decrementing!
            counter -= 1
            timerLabel.text = "\(counter)"
            
        } else {
            
            // No More Time! Stop Timer!
            gameSounds.playInorrectAnswerSound()
            timesUp()
            resetTimer()
        }
    }
    
    
    
    // MARK: Helper Methods
    
    
    // This function stops timer, resets the counter and the label
    
    func resetTimer() {
        
        timer.invalidate()
        counter = 15
        timerLabel.text = "15"
    }
    
    
    
    // This function will stop timer and notify user of time running out — they are not able to select any options at this point
    
    func timesUp() {
        
        // Question marked as wrong
        questionsAsked += 1
        timer.invalidate()
        hideOptionButtons(true)
        timerLabel.hidden = true
        showAnswerButton.hidden = true
        resultField.textColor = UIColor.init(red: 253/255.0, green: 162/255.0, blue: 104/255.0, alpha: 1.0)
        resultField.text = "Sorry, you ran out of time!"
    }

    
    
    // This function notifies user if they won or lost
    
    func didPlayerWin() {
        
        let incorrectAnswersLimit = questionsPerRound / 2
        
        if (correctAnswers == questionsPerRound) {
            
            // Perfect Score
            gameSounds.playWinnerSound()
            displayScoreLabel.text = "WOOHOO!! You won. You are a champion!"
        
        } else if (correctAnswers <= incorrectAnswersLimit) {
            
            // User Failed
            gameSounds.playGameOverSound()
            displayScoreLabel.text = "Sorry, you only got \(correctAnswers) out of \(questionsPerRound) correct.\n Better luck next time!"
        
        } else {

            // User Passed
            gameSounds.playWinnerSound()
            displayScoreLabel.text = "Nice! You got \(correctAnswers) out of \(questionsPerRound) correct!"
        }
    }
   
    
    
    // This function grabs the options from the Current Trivia Set and sets them on the buttons for the user to select
    
    func displayOptions() {
        
        option1Button.setTitle(currentTrivia.options[0], forState: .Normal)
        option2Button.setTitle(currentTrivia.options[1], forState: .Normal)
        option3Button.setTitle(currentTrivia.options[2], forState: .Normal)
        option4Button.setTitle(currentTrivia.options[3], forState: .Normal)
        
        hideOptionButtons(false)
        resetOptionButtonDisplay()
    }
    
    
    
    // This displays user's final score once game ends
    
    func displayScore() {
        
        // Hide all buttons and labels
        hideOptionButtons(true)
        nextQuestionButton.hidden = true
        showAnswerButton.hidden = true
        questionField.hidden = true
        
        // Display Play Again button
        playAgainButton.hidden = false
        
        // Calls function to Display Results
        didPlayerWin()
    }

    
    
    // This function controls the visibily of the Option Buttons
    
    func hideOptionButtons(boolean: Bool) {
        
        let options: [UIButton] = [option1Button, option2Button, option3Button, option4Button]
        
        for option in options {
            
            option.hidden = boolean
        }
    }
    
    
    
    // This function resets any styling or settings on the Option Buttons
    
    func resetOptionButtonDisplay() {
        
        let options: [UIButton] = [option1Button, option2Button, option3Button, option4Button]
        
        for option in options {
            
            option.highlighted = false
            option.selected = false
        }
    }
}

