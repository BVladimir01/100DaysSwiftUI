//
//  ContentView.swift
//  Bookworm
//
//  Created by Vladimir on 24.12.2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Query var books: [Book]
    @Environment(\.modelContext) var modelContext
    
    @State private var isAddingBook = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                                    .font(.footnote)
                            }
                        }
                    }
                }
            }
                .sheet(isPresented: $isAddingBook) {
                    AddBookView()
                }
                .navigationTitle("Bookworm")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add book", systemImage: "plus") {
                            isAddingBook.toggle()
                        }
                    }
                }
        }
    }
}

@Model
class Student: Identifiable {
    var id: UUID
    var name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}

#Preview {
    ContentView()
}
