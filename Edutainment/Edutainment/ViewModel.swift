//
//  ViewModel.swift
//  Edutainment
//
//  Created by Vladimir on 28.11.2024.
//
import SwiftUI

class ViewModel: ObservableObject {
    
    @Published private var game = GameModel()
    
    var tableSize: Int {
        didSet {
            game.tableSize = tableSize
        }
    }
    
    var numQuestions: Int {
        didSet {
            game.numQuestions = numQuestions
        }
    }
    
    var gameEnded : Bool {
        didSet {
            if !gameEnded && oldValue {
                startNewGame()
            }
        }
    }
    
    init(game: GameModel = GameModel()) {
        self.game = game
        tableSize = game.tableSize
        numQuestions = game.numQuestions
        gameEnded = game.gameEnded
    }
    
    func send(answer: String) {
        game.accept(answer: Int(answer) ?? 0)
        gameEnded = game.gameEnded
    }
    
    func startNewGame() {
        game.newGame()
        gameEnded = false
    }
    
    var questionIndex: Int {
        game.questionIndex
    }
    
    var score: Int {
        game.score
    }
    
    var questionNumber: Int {
        min(questionIndex + 1, numQuestions)
    }
    
    var currentQuestion: (x: Int, y: Int) {
        game.currentQuestion
    }
}
