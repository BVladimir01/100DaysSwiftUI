//
//  Models.swift
//  CupcakeCorner
//
//  Created by Vladimir on 17.12.2024.
//

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct Response: Codable {
    let results: [Result]
}
