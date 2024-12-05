//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Vladimir on 16.11.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var appOption = Option.random() {
        didSet {
            if appOption == oldValue {
                userShouldWin.toggle()
            }
            else {
                userShouldWin = Bool.random()
            }
        }
    }
    @State private var userShouldWin = Bool.random()
    @State private var userScore = 0 {
        didSet {
            if userScore == maxScore {
                endGameAlert = true
            }
        }
    }
    
    @State private var endGameAlert = false
    
    private var maxScore = 10
    
    var body: some View {
        VStack(spacing: 50) {
            gameTitle
            Spacer()
            userTask
            Spacer()
            buttonsView
            userScoreView
        }
        .padding()
    }
    
    private var gameTitle: some View {
        Text("RockPaperScissors")
            .font(.largeTitle.bold())
            .padding()
    }
    
    private var userTask: some View {
        VStack {
            Text("Pick option to " + (userShouldWin ? "win" : "lose") + " against")
                .font(.title)
            Text("\(appOption)")
                .font(.system(size: 50))
        }
        .padding()
    }
    
    private var buttonsView: some View {
        HStack {
            ForEach(Option.allCases.filter( {$0 != appOption })) { option in
                Button("\(option)") {
                    withAnimation(.none) {
                        userPressed(option)
                    }
                }
                .font(.system(size: 50))
                .padding()
            }
        }
    }
    
    private func userPressed(_ option: Option) {
        let a = option.wins(against: appOption)
        let b = userShouldWin
//        exclusive nor
        if xnor(a, b) {
            userScore += 1
        }
        
        appOption = Option.random()
    }
    
    func xnor(_ a: Bool, _ b: Bool) -> Bool {
        return ((a&&b) || ((!a)&&(!b)))
    }
    
    private var userScoreView: some View {
        Text("Your score is \(userScore)/\(maxScore)")
            .font(.title)
            .padding()
            .alert(Text("Game is over"), isPresented: $endGameAlert) {
                Button("Continue") {
                    userScore = 0
                    appOption = Option.random()
                }
            }
    }
    
    
    private enum Option: Int, CaseIterable, Identifiable, CustomStringConvertible {
        
        case rock = 0
        case paper = 1
        case scissors = 2
        
        var id: Option {
            self
        }
        
        var description: String {
            switch self {
            case .rock:
                "✊"
            case .paper:
                "✋"
            case .scissors:
                "✌️"
            }
        }
        
        func wins(against option: Option) -> Bool {
            (option.rawValue + 1) % 3 == self.rawValue
        }
        
        static func random() -> Option {
            Option.allCases.randomElement()!
        }
    }
}

#Preview {
    ContentView()
}
