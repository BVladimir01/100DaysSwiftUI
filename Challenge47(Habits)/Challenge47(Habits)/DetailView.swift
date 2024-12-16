//
//  DetailView.swift
//  Challenge47(Habits)
//
//  Created by Vladimir on 16.12.2024.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var habit: Habit
    
    var body: some View {
        List {
            Section("Description") {
                TextField("edit description here", text: $habit.description)
            }
            Section("Completion count") {
                Stepper("Completed \(habit.counter) times", value: $habit.counter, step: 1) { _ in
                    if habit.counter < 0 {
                        habit.counter = 0
                    }
                }
            }
        }
        .navigationTitle($habit.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
