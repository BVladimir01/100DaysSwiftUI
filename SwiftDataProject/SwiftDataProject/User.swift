//
//  User.swift
//  SwiftDataProject
//
//  Created by Vladimir on 21.01.2025.
//

import Foundation
import SwiftData


@Model
class User {
    var name: String
    var city: String
    var joinDate: Date
    
    init(name: String, city: String, joinDate: Date = .now) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
