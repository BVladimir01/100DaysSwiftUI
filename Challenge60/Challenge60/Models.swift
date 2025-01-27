//
//  Models.swift
//  Challenge60
//
//  Created by Vladimir on 27.01.2025.
//

import SwiftData
import Foundation

struct User: Identifiable, Codable, Hashable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
}


struct Friend: Identifiable, Codable, Hashable {
    var id: String
    var name: String
}
