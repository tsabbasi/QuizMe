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
    
    var gameSounds = GameSoundModel()
  
    let questionsPerRound = triviaCollection.count
    var questionsAsked = 0
    var correctQuestions = 0
    
    
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
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        gameSounds.loadCorrectAnswerSound()
        gameSounds.loadIncorrectAnswerSound()
        // Start game
//        playGameStartSound()
        playAgainButton.hidden = true
        nextQuestionButton.hidden = false
        showAnswerButton.hidden = true
        questionField.text = currentTrivia.question
        displayOptions()
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
        
        
        // Check if selected option matches the answer
        if (sender === option1Button &&  option1Button.currentTitle == correctAnswer) ||
            (sender === option2Button && option2Button.currentTitle == correctAnswer) ||
            (sender === option3Button && option3Button.currentTitle == correctAnswer) ||
            (sender === option4Button && option4Button.currentTitle == correctAnswer) {
            gameSounds.playCorrectAnswerSound()
            
            correctQuestions += 1
            
            resultField.textColor = UIColor.init(red: 21/255.0, green: 147/255.0, blue: 135/255.0, alpha: 1.0)
            resultField.text = "Correct!"
            showAnswerButton.hidden = true
            
        } else {
            gameSounds.playInorrectAnswerSound()
            resultField.textColor = UIColor.init(red: 253/255.0, green: 162/255.0, blue: 104/255.0, alpha: 1.0)
            
            resultField.text = "Sorry, wrong answer."
            showAnswerButton.hidden = false
            hideOptionButtons(true)
        }
        
    }
    
    
    
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
    
    
 
    @IBAction func showNextQuestion() {
        
        if questionsAsked == questionsPerRound {
            // Game is over
            resultField.text = ""
            nextQuestionButton.hidden = true
            displayScore()
        } else {
            // Continue game
            currentTrivia = generateTrivia()
            showAnswerButton.hidden = true
            questionField.text = currentTrivia.question
            resultField.text = ""
            displayOptions()
            playAgainButton.hidden = true
        }
            
    }
    
    
    @IBAction func playAgain() {
        // Show the answer buttons
        hideOptionButtons(false)
        displayScoreLabel.text = ""
        nextQuestionButton.hidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        showNextQuestion()

    }
    
    func didPlayerWin() {
        
        let playerLost = questionsPerRound / 2
        
        if (correctQuestions == questionsPerRound) {
            
            displayScoreLabel.text = "WOOHOO!! You Won!"
        
        } else if (correctQuestions <= playerLost) {
            
//            gameSounds.playGameOverSound()
        
            displayScoreLabel.text = "Sorry, you only got \(correctQuestions) out of \(questionsPerRound) correct.\n Better luck next time!"
        
        } else {
        
            displayScoreLabel.text = "Nice! You got \(correctQuestions) out of \(questionsPerRound) correct!"
        }
        
    }
    

    
    func displayOptions() {
        option1Button.setTitle(currentTrivia.options[0], forState: .Normal)
        option2Button.setTitle(currentTrivia.options[1], forState: .Normal)
        option3Button.setTitle(currentTrivia.options[2], forState: .Normal)
        option4Button.setTitle(currentTrivia.options[3], forState: .Normal)
        
        hideOptionButtons(false)
        
        resetOptionButtonDisplay()
        
    }
    
    func displayScore() {
        // Hide the answer buttons
        hideOptionButtons(true)
        nextQuestionButton.hidden = true
        showAnswerButton.hidden = true
        
        
        // Display play again button
        playAgainButton.hidden = false
        
        didPlayerWin()
        
//        questionField.text = "Woohoo!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    

    
    // MARK: Helper Methods
    
    func hideOptionButtons(boolean: Bool) {
        let options: [UIButton] = [option1Button, option2Button, option3Button, option4Button]
        for option in options {
            option.hidden = boolean
        }
    }
    
    func resetOptionButtonDisplay() {
        let options: [UIButton] = [option1Button, option2Button, option3Button, option4Button]
        for option in options {
            
            option.highlighted = false
            option.selected = false
        }
        
    }

}

