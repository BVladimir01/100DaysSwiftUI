//
//  ContentView.swift
//  Challenge47(Habits)
//
//  Created by Vladimir on 15.12.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var habitsStore = HabitsStore()
    @State private var editingNewHabit = false
    var body: some View {
        NavigationStack {
            List {
                ForEach($habitsStore.habits) { $habit in
                    NavigationLink {
                        DetailView(habit: $habit)
                    } label: {
                        HStack {
                            Text(habit.title)
                            Spacer()
                            Text(habit.counter.formatted())
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .onDelete { indexSet in
                    habitsStore.habits.remove(atOffsets: indexSet)
                }
            }
            .navigationDestination(isPresented: $editingNewHabit) {
                EditView(habits: $habitsStore.habits)
            }
            .navigationTitle("Habits")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add", systemImage: "plus") {
                        editingNewHabit.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
