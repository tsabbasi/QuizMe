//
//  MyTrivia.swift
//  TrueFalseStarter
//
//  Created by Tuba Abbasi on 8/17/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//



struct MyTrivia {
    let triviaSet1 = Trivia(question: "This was the only US President to serve more than two consecutive terms.", options: ["George Washington", "Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"], answer: "Franklin D. Roosevelt")
    
    let triviaSet2 = Trivia(question: "Which of the following countries has the most residents?", options: ["Nigeria", "Russia", "Iran", "Vietnam"], answer: "Nigeria")
    
    let triviaSet3 = Trivia(question: "In what year was the United Nations founded?", options: ["1918", "1919", "1945", "1954"], answer: "1945")
    
    let triviaSet4 = Trivia(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", options: ["Paris", "Washington D.C.", "New York City", "Boston"], answer: "New York City")
    
    let triviaSet5 = Trivia(question: "Which nation produces the most oil?", options: ["Iran", "Iraq", "Brazil", "Canada"], answer: "Canada")
    
    let triviaSet6 = Trivia(question: "Which country has most recently won consecutive World Cups in Soccer?", options: ["Italy", "Brazil", "Argetina", "Spain"], answer: "Brazil")
    
    let triviaSet7 = Trivia(question: "Which of the following rivers is longest?", options: ["Yangtze", "Mississippi", "Congo", "Mekong"], answer: "Mississippi")
    
    let triviaSet8 = Trivia(question: "Which city is the oldest?", options: ["Mexico City", "Cape Town", "San Juan", "Sydney"], answer: "Mexico City")
    
    let triviaSet9 = Trivia(question: "Which country was the first to allow women to vote in national elections?", options: ["Poland", "United States", "Sweden", "Senegal"], answer: "Poland")
    
    let triviaSet10 = Trivia(question: "Which of these countries won the most medals in the 2012 Summer Games?", options: ["France", "Germany", "Japan", "Great Britian"], answer: "Great Britian")
    
    let triviaCollection = [triviaSet1, triviaSet2, triviaSet3, triviaSet4, triviaSet5, triviaSet6, triviaSet7, triviaSet8, triviaSet9, triviaSet10]
//
//    // This function randomely selects and returns a trivia set from the triviaCollection array
//    
//    func generateTrivia() -> Trivia {
//        
//        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(triviaCollection.count)
//        let triviaSelection = triviaCollection[indexOfSelectedQuestion]
//        return triviaSelection
//        
//    }

}