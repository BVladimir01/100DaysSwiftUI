//
//  Models.swift
//  Challenge47(Habits)
//
//  Created by Vladimir on 15.12.2024.
//

struct Habit: Codable, Identifiable, Hashable {
    var title: String
    var description: String
    var counter = 0
    var id: String {
        title
    }
}
