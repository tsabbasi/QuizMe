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
    
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    
    var gameSound: SystemSoundID = 0
    
//    let trivia: [[String : String]] = [
//        ["Question": "Only female koalas can whistle", "Answer": "False"],
//        ["Question": "Blue whales are technically whales", "Answer": "True"],
//        ["Question": "Camels are cannibalistic", "Answer": "False"],
//        ["Question": "All ducks are birds", "Answer": "True"]
//    ]
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
//    @IBOutlet weak var trueButton: UIButton!
//    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        // Start game
        playGameStartSound()
        questionField.text = currentTrivia.question
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func displayQuestion() {
//        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(trivia.count)
//        let questionDictionary = trivia[indexOfSelectedQuestion]
//        questionField.text = questionDictionary["Question"]
//        playAgainButton.hidden = true
//    }
    
    func displayOptions() {
        option1Button.setTitle(currentTrivia.options[0], forState: <#T##UIControlState#>)
        option2Button.setTitle(currentTrivia.options[1], forState: <#T##UIControlState#>)
        option3Button.setTitle(currentTrivia.options[2], forState: <#T##UIControlState#>)
        option4Button.setTitle(currentTrivia.options[3], forState: <#T##UIControlState#>)
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
        if (sender === option1Button &&  option1Button.titleLabel == correctAnswer) ||
            (sender === option2Button && option2Button == correctAnswer) ||
            (sender === option3Button && option3Button == correctAnswer) ||
            (sender === option4Button && option4Button == correctAnswer) {
            correctQuestions += 1
            questionField.text = "Correct!"
        } else {
            questionField.text = "Sorry, wrong answer!"
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    
    
    
    
//    @IBAction func checkAnswer(sender: UIButton) {
//        // Increment the questions asked counter
//        questionsAsked += 1
//        
//        let selectedQuestionDict = trivia[indexOfSelectedQuestion]
//        let correctAnswer = selectedQuestionDict["Answer"]
//        
//        if (sender === trueButton &&  correctAnswer == "True") || (sender === falseButton && correctAnswer == "False") {
//            correctQuestions += 1
//            questionField.text = "Correct!"
//        } else {
//            questionField.text = "Sorry, wrong answer!"
//        }
//        
//        loadNextRoundWithDelay(seconds: 2)
//    }
    
    
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            
            // Resetting current trivia
            
            currentTrivia = generateTrivia()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        option1Button.hidden = false
        option2Button.hidden = false
        option3Button.hidden = true
        option4Button.hidden = true
        
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

