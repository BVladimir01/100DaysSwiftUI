//
//  AddBookView.swift
//  Bookworm
//
//  Created by Vladimir on 18.01.2025.
//

import SwiftData
import SwiftUI

struct AddBookView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = Book.Genre.fantasy
    @State private var review = ""
    @State private var rating = 5
    
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    @State private var showingAlert = false

    
    var body: some View {
        NavigationStack {
            Form {
                topSection
                reviewSection
                saveSection
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") {}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private var topSection: some View {
        Section {
            TextField("Name of book", text: $title)
            TextField("Author's name", text: $author)
            Picker("Genre", selection: $genre) {
                ForEach(Book.Genre.allCases, id: \.self) {
                    Text($0.rawValue.capitalized)
                }
            }
        }
    }
    
    private var reviewSection: some View {
        Section("Write review") {
            TextEditor(text: $review)
            HStack {
                Text("Rating")
                Spacer()
                RatingView(rating: $rating)
            }
        }
    }
    
    private var saveSection: some View {
        Section {
            HStack {
                Spacer()
                Button("Save", action: saveAction)
                Spacer()
            }
        }
    }
    
    private func saveAction() {
        if bookIsValid() {
            modelContext.insert(Book(title: title, author: author, genre: genre, rating: rating, review: review))
            dismiss()
        } else {
            determineSavingIssue()
            showingAlert = true
        }
    }
    
    private func bookIsValid() -> Bool {
        return title.isNotEmpty && author.isNotEmpty
    }
    
    private func determineSavingIssue() {
        if title.isEmpty {
            alertTitle = "Book's title is empty"
            alertMessage = "Enter valid name of book"
        } else {
            alertTitle = "Author's name is empty"
            alertMessage = "Enter valid author's name"
        }
    }
}

#Preview {
    AddBookView()
}
