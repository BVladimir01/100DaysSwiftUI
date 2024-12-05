//
//  ContentView.swift
//  WordScramble
//
//  Created by Vladimir on 21.11.2024.
//

import SwiftUI
import UIKit
import Foundation

struct ContentView: View {
    
    @State private var newWord = ""
    @State private var rootWord = generateNewWord() {
        didSet {
            if rootWord == oldValue {
                rootWord = Self.generateNewWord()
            }
        }
    }
    @State private var usedWords: [String] = .init()
    
    @State private var userScore = 0
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            List {
                textFieldSection
                usedWordsSection
            }
            .navigationTitle(rootWord)
            .toolbar {
                Button("New Game") {
                    userScore = 0
                    usedWords = []
                    rootWord = Self.generateNewWord()
                }
                .font(.title2)
            }
            Text("Your score: \(userScore)")
                .font(.largeTitle)
        }
        .alert(alertTitle, isPresented: $showAlert) { } message: {
            Text(alertMessage)
        }
    }
    
    private var textFieldSection: some View {
        Section {
            TextField("Enter word", text: $newWord)
                .onSubmit(addNewWord)
                .textInputAutocapitalization(.never)
        }
    }
    
    private var usedWordsSection: some View {
        Section {
            ForEach(usedWords, id: \.self) { word in
                HStack {
                    Text(word)
                    Image(systemName: "\(word.count).circle")
                }
            }
        }

    }
    
    private func addNewWord() {
        let answer = newWord.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard validateNewWord(answer, from: rootWord) else {
            newWord = ""
            return }
        withAnimation() {
            usedWords.insert(answer, at: 0)
        }
        userScore += answer.count
        newWord = ""
    }
    
    private func validateNewWord(_ newWord: String, from rootWord: String) -> Bool {
        if let error = locateError(newWord: newWord, rootWord: rootWord) {
            let (errorTitle, errorMessage) = error.description
            callAlert(title: errorTitle, message: errorMessage)
            return false
        } else {
            return true
        }
    }
    
    private func callAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
    
    static private func generateNewWord() -> String {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let words = startWords.components(separatedBy: .newlines)
                if let startWord = words.randomElement() {
                    return startWord
                }
            }
        }
        fatalError()
    }
    
    enum wordError {
        case isEmpty, equalsRoot, isShort, alredyUsed, isImpossible(newWord: String, rootWord: String), isNotReal
        
        var description: (title: String, message: String) {
            switch self {
            case .isEmpty:
                return ("Word is empty", "Enter a word")
            case .equalsRoot:
                return ("Word matches root word", "Do not trick the game")
            case .isShort:
                return ("Word too short", "Try something longer")
            case .alredyUsed:
                return ("Word already used", "Be more original")
            case .isImpossible(let newWord, let rootWord):
                return ("Word not impossible", "Can not spell \"\(newWord)\" from \"\(rootWord)\"")
            case .isNotReal:
                return ("Word not recognized", "Do not make up words")
            }
        }
    }
    
    private func wordIsPossible(_ word: String, from rootWord: String) -> Bool {
        var rootWord = rootWord
        for char in word {
            if let index = rootWord.firstIndex(of: char) {
                rootWord.remove(at: index)
            } else {
                return false
            }
        }
        return true
    }
    
    private func wordIsReal(_ word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    private func locateError(newWord: String, rootWord: String) -> wordError? {
        if newWord.isEmpty {
            return .isEmpty
        } else if newWord.count < 3 {
            return .isShort
        } else if newWord == rootWord {
            return .equalsRoot
        } else if usedWords.contains(newWord) {
            return .alredyUsed
        } else if !wordIsPossible(newWord, from: rootWord) {
            return .isImpossible(newWord: newWord, rootWord: rootWord)
        } else if !wordIsReal(newWord) {
            return .isNotReal
        } else {
            return nil
        }
    }
}


#Preview {
    ContentView()
}
