//
//  ContentView.swift
//  Challenge47(Habits)
//
//  Created by Vladimir on 15.12.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var habitsStore = HabitsStore()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(habitsStore.habits) {habit in
                    NavigationLink(habit.title) {
                        Text(habit.description)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
