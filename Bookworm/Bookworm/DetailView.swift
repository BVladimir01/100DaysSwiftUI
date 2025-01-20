//
//  DetailView.swift
//  Bookworm
//
//  Created by Vladimir on 19.01.2025.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    
    let book: Book
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        detailScrollView
            .navigationTitle(book.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Delete this book", systemImage: "trash") {
                    showingDeleteAlert = true
                }
            }
            .alert("Delete this book", isPresented: $showingDeleteAlert) {
                Button("Delete", role: .destructive, action: deleteBook)
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Are you sure?")
            }
    }
    
    private var genreView: some View {
        ZStack(alignment: .bottomTrailing) {
            image(for: book.genre)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.brown)
            
            Text(book.genre.rawValue.uppercased())
                .font(.caption)
                .fontWeight(.black)
                .padding(8)
                .foregroundStyle(.white)
                .background(.black.opacity(0.75))
                .clipShape(.capsule)
                .offset(x: -20, y: -20)
        }
    }
    
    @ViewBuilder private var mainContentView: some View {
        Text(book.author)
            .font(.title)
            .foregroundStyle(.secondary)
        Text(book.review)
            .padding()
    }
    
    private var dateView: some View {
        let addDate = book.addDate?.formatted(date: .abbreviated, time: .shortened) ?? "some day"
        return HStack {
            Spacer()
            Text("Book added on \(addDate)")
        }
    }
    
    private var detailScrollView: some View {
        ScrollView {
            genreView
            .padding()
            mainContentView
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
                .padding(.bottom)
            dateView
        }
        .scrollBounceBehavior(.basedOnSize)
    }
    
    private func image(for genre: Book.Genre) -> Image {
        let imageName = genre.rawValue.capitalized
        if let uiimage = UIImage(named: imageName) {
            return Image(uiImage: uiimage)
        } else {
            return Image(systemName: "book.fill")
        }
    }
    
    private func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let sample = Book(title: "Title", author: "Author", genre: .thriller, rating: 4, review: "Review")
        return DetailView(book: sample).modelContainer(container)
    } catch {
        return Text("\(error.localizedDescription) happened")
    }
}
