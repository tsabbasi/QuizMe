//
//  GameSoundModel.swift
//  TrueFalseStarter
//
//  Created by Tuba Abbasi on 8/18/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import AudioToolbox

var correctSound: SystemSoundID = 0
var incorrectSound: SystemSoundID = 0
var gameOverSound: SystemSoundID = 0
var winnerSound: SystemSoundID = 0
var startGameSound: SystemSoundID = 0

struct GameSoundModel {
    
    // These Functions Loads Game Sounds
    
    func loadCorrectAnswerSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("correct", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &correctSound)
    }
    
    func loadIncorrectAnswerSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("uhOh", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &incorrectSound)
    }
    
    func loadGameOverSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("lose", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameOverSound)
    }
    
    func loadWinnerSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("cheer", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &winnerSound)
    }
    
    
    // These Functions Play Game Sounds
    
    func playCorrectAnswerSound() {
        AudioServicesPlaySystemSound(correctSound)
    }
    
    
    func playInorrectAnswerSound() {
        AudioServicesPlaySystemSound(incorrectSound)
    }

    
    func playGameOverSound() {
        AudioServicesPlaySystemSound(gameOverSound)
    }
    
    
    func playWinnerSound() {
        AudioServicesPlaySystemSound(winnerSound)
    }
}