//
//  ContentView.swift
//  Edutainment
//
//  Created by Vladimir on 28.11.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var edutainmentGame = ViewModel()
    @State var gameIsOn = false
    
    var body: some View {
        NavigationStack {
            Form {
                questionNumberPicker
                tableSizePicker
            }
            .navigationTitle("Edutainment")
            .navigationDestination(isPresented: $gameIsOn) {
                GameView(edutainmentGame: edutainmentGame)
            }
            gameStartButton
        }
    }
    
    private var questionNumberPicker: some View {
        Picker("How many questions?", selection: $edutainmentGame.numQuestions) {
            ForEach([5, 10, 20], id: \.self) {
                Text($0.formatted())
            }
        }
        .pickerStyle(.inline)
    }
    
    private var tableSizePicker: some View {
        Picker("Table size", selection: $edutainmentGame.tableSize) {
            ForEach(2..<13, id: \.self) {
                Text($0.formatted())
            }
        }
        .pickerStyle(.wheel)
    }
    
    private var gameStartButton: some View {
        Button("Start game") {
            edutainmentGame.startNewGame()
            gameIsOn = true
        }
        .font(.title)
    }
    
}


struct GameView: View {
    @ObservedObject var edutainmentGame: ViewModel
    @State private var answer = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 100) {
            gameStatus
            question
            answerField
            Spacer()
        }
        .padding()
        .alert("Congrats", isPresented: $edutainmentGame.gameEnded) {
            newGameButton
            settingsButton
        } message: {
            alertMessage
        }
    }
    
    private var gameStatus: some View {
        HStack {
            Text("Question: \(edutainmentGame.questionNumber)/\(edutainmentGame.numQuestions)")
            Text("Score: \(edutainmentGame.score)/\(edutainmentGame.questionIndex)")
        }
        .font(.title)
    }
    
    private var question: some View {
        let questionString = "What is \(edutainmentGame.currentQuestion.x) x \(edutainmentGame.currentQuestion.y) ?"
        return Text(questionString).font(.largeTitle.bold())
    }
    
    private var answerField: some View {
        HStack {
            TextField("Enter answer", text: $answer)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
            Button("Submit") {
                submitAnswer()
            }
        }
        .font(.largeTitle)
    }
    
    private var newGameButton: some View {
        Button("New Game") {
            edutainmentGame.startNewGame()
        }
    }
    
    private var settingsButton: some View {
        Button("Back to settings") {
            edutainmentGame.startNewGame()
            dismiss()
        }
    }
    
    private var alertMessage: some View {
        Text("Your final score is \(edutainmentGame.score)/\(edutainmentGame.questionIndex)")
    }
    
    private func submitAnswer() {
        edutainmentGame.send(answer: answer)
        answer = ""
    }
}

#Preview {
    ContentView()
}
