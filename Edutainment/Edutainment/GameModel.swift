//
//  GameModel.swift
//  Edutainment
//
//  Created by Vladimir on 28.11.2024.
//


struct GameModel {
    var numQuestions: Int = 10 {
        didSet { settingsChanged() }
    }
    var tableSize: Int = 10 {
        didSet { settingsChanged() }
    }
    private(set) var score: Int = 0
    private(set) var questionIndex: Int = 0
    private(set) var currentQuestion: (x: Int, y: Int) = (Int.random(in: 2...10), Int.random(in: 2...10)) {
        didSet {
            if currentQuestion == oldValue {
                generateQuestion()
            }
        }
    }
    private(set) var gameEnded: Bool = false
    
    mutating private func generateQuestion() {
        currentQuestion = (Int.random(in: 2...tableSize), Int.random(in: 2...tableSize))
    }
    
    private func isTrue(answer: Int) -> Bool {
        return currentQuestion.x * currentQuestion.y == answer
    }
    
    mutating func accept(answer: Int) {
        guard !gameEnded else { fatalError() }
        if isTrue(answer: answer) {
            score += 1
        }
        generateQuestion()
        questionIndex += 1
        if questionIndex == numQuestions {
            gameEnded = true
        }
    }
    
    mutating func newGame() {
        score = 0
        questionIndex = 0
        generateQuestion()
        gameEnded = false
    }
    
    mutating private func settingsChanged() {
        score = 0
        questionIndex = 0
        generateQuestion()
    }
}
