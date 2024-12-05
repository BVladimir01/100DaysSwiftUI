//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Vladimir on 12.11.2024.
//

import SwiftUI

struct ContentView: View {

    private var numEndGame = 3
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showScore = false
    
    @State private var userAnswer = 0
    
    @State private var gameScore = 0 {
        didSet {
            if gameScore < 0 {
                gameScore = 0
            }
        }
    }
    
    @State private var numAnswered = 0

    @State var tapped = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the flag")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                gameView
                Spacer()
                Spacer()
                Text("Your score is \(gameScore)")
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                Spacer()
            }
            .padding()
        }
    }
    
    private var questionView: some View {
        VStack {
            Text("Tap the flag of")
            Text("\(countries[correctAnswer])")
        }
        .foregroundStyle(.secondary)
        .font(.title.bold())
    }
    
    private var flagsView: some View {
        VStack(spacing: 15) {
            ForEach(0..<3) { number in
                Button {
                    withAnimation() {
                        flagTapped(number)
                    }
                } label: {
                    Image(countries[number])
                }
                .modifier(FlagModifier(number: number, userAnswer: userAnswer, tapped: tapped))
            }
            .clipShape(.rect(cornerRadius: 15))
            .shadow(radius: 5)
        }
    }
    
    struct FlagModifier: ViewModifier {
        var number: Int
        var userAnswer: Int
        var tapped: Bool
        
        func body(content: Content) -> some View {
            let angle = (number == userAnswer ? 360*(tapped ? 1.0 : 0.0) : 0)
            let opacity = (number == userAnswer ? 1 : (tapped ? 0.25 : 1))
            let scale = (number == userAnswer ? 1 : (tapped ? 0.75 : 1))
            return content
                .rotation3DEffect(.degrees(angle), axis: (0,1,0))
                .opacity(opacity)
                .scaleEffect(scale)
        }
    }
    
    private var gameView: some View {
        VStack(spacing: 15) {
            questionView
            flagsView
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.regularMaterial)
        .clipShape(.rect(cornerRadius: 20))
        .alert(alertTitle, isPresented: $showScore) {
            alertButton
        } message: {
            alertMessage
        }
    }
    
    private var alertTitle: String {
        if numAnswered == numEndGame {
            "Congrats"
        } else {
            userAnswer == correctAnswer ? "Correct" : "Wrong"
        }
    }
    
    private var alertMessage: some View {
        if numAnswered == numEndGame {
            Text("Game is over\n" + "Your final score is \(gameScore)")
        } else {
            Text((userAnswer == correctAnswer ? "" : "That's the flag of \(countries[userAnswer]).\n") + "Your score is now \(gameScore)")
        }
    }
    
    private var alertButton: some View {
        if numAnswered == numEndGame {
            Button("New Game") {
                gameScore = 0
                numAnswered = 0
                countries.shuffle()
                correctAnswer = Int.random(in: 0...2)
                tapped = false
            }
        } else {
            Button("Continue") {
                countries.shuffle()
                correctAnswer = Int.random(in: 0...2)
                tapped = false
            }
        }
    }
    
    private func flagTapped(_ number: Int) {
        tapped = true
        userAnswer = number
        numAnswered += 1
        gameScore += (userAnswer == correctAnswer) ? +1 : -1
        showScore = true
    }
}


struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundStyle(.tint)
    }
}

extension View {
    func titled() -> some View {
        self.modifier(TitleModifier())
    }
}
#Preview {
    ContentView()
}
