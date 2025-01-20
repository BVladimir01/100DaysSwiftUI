//
//  Models.swift
//  Bookworm
//
//  Created by Vladimir on 18.01.2025.
//

import SwiftData
import Foundation

@Model
class Book {
    var title: String
    var author: String
    var genre: Genre
    var rating: Int
    var review: String
    var addDate: Date?
    
    init(title: String, author: String, genre: Genre, rating: Int, review: String) {
        self.title = title
        self.author = author
        self.genre = genre
        self.rating = rating
        self.review = review
        self.addDate = Date.now
    }
    
    enum Genre: String, CaseIterable, Identifiable, Codable {
        case fantasy, horror, scify, kids, mistery
        case poetry, romance, thriller, detective
        var id: Genre { self }
    }
}
