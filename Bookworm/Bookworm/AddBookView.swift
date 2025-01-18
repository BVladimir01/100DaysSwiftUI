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
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(Book.Genre.allCases, id: \.self) {
                            Text($0.rawValue.capitalized)
                        }
                    }
                }
                
                Section("Write review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating, label: "Rating")
                    }
                
                Section {
                    Button("Save") {
                        modelContext.insert(Book(title: title, author: author, genre: genre, rating: rating, review: review))
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddBookView()
}
