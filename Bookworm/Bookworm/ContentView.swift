//
//  ContentView.swift
//  Bookworm
//
//  Created by Vladimir on 24.12.2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Query(sort: [SortDescriptor(\Book.rating, order: .reverse), SortDescriptor(\Book.author), SortDescriptor(\Book.title)]) var books: [Book]
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
                .onDelete { indexSet in
                    deleteBooks(at: indexSet)
                }
            }
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
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
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
        }
    }
    
    private func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
