//
//  EditView.swift
//  Challenge47(Habits)
//
//  Created by Vladimir on 16.12.2024.
//

import SwiftUI

struct EditView: View {
    
    @Binding var habits: [Habit]
    @State private var title = ""
    @State private var description = ""
    @State private var count = 0
    @State private var upperBound = 20
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            Section("Title") {
                TextField("edit habit title here", text: $title)
            }
            Section("Description") {
                TextField("edit habit description here", text: $description)
            }
            Section {
                Picker("Number of completions", selection: $count) {
                    ForEach(0...upperBound, id: \.self) {
                        Text($0.formatted())
                    }
                }
                .pickerStyle(.wheel)
                .onChange(of: count, initial: false) {
                    if count == upperBound {
                        upperBound += 10
                    }
                }
            } footer: {
                Text("How many times you completed this habit?")
            }
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button("Submit") {
                    habits.insert(Habit(title: title, description: description, counter: count), at: 0)
                    dismiss()
                }
            }
        }
    }
}

//#Preview {
//    EditView()
//}
