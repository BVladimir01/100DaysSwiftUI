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
            booksListView
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
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
            .sheet(isPresented: $isAddingBook) {
                AddBookView()
            }
        }
    }
    
    private var booksListView: some View {
        List {
            ForEach(books) { book in
                NavigationLink(value: book) {
                    listLabel(for: book)
                }
            }
            .onDelete { indexSet in
                deleteBooks(at: indexSet)
            }
        }
    }
    
    private func listLabel(for book: Book) -> some View {
        HStack {
            EmojiRatingView(rating: book.rating)
                .font(.largeTitle)
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                Text(book.author)
                    .font(.footnote)
            }
            .foregroundStyle(book.rating == 1 ? .red : .primary)
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
