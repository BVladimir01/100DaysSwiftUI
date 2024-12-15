//
//  HabitsStore.swift
//  Challenge47(Habits)
//
//  Created by Vladimir on 15.12.2024.
//

import SwiftUI

@Observable
class HabitsStore {
    
    var habits: [Habit] {
        didSet {
            
        }
    }
    
    init() {
        if let habitsData = UserDefaults.standard.data(forKey: habitsKey) {
            if let decodedHabits = try? JSONDecoder().decode([Habit].self, from: habitsData) {
                habits = decodedHabits
                return
            }
        }
        habits = [Habit(title: "title", description: "description", counter: 0)]
    }
    
    private func save() {
        if let encodedHabits = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(encodedHabits, forKey: habitsKey)
        }
    }
    
    private let habitsKey = "myHabits"
}
