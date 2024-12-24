//
//  ContentView.swift
//  Bookworm
//
//  Created by Vladimir on 24.12.2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Query var students: [Student]
    @Environment(\.modelContext) var modelContext
 
    var body: some View {
        NavigationStack {
            List(students) { student in
                Text(student.name)
            }
            Button("add student") {
                print("pressed")
                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                let newStudent = Student(name: firstNames.randomElement()!)
                print(newStudent.name)
                modelContext.insert(newStudent)
                
                do {
                    try modelContext.save()
                } catch {
                    print("Failed to save: \(error)")
                }
                
            }
            .font(.largeTitle)
            .navigationTitle("Classroom")
        }
    }
}

@Model
class Student: Identifiable {
    var id: UUID
    var name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}

#Preview {
    ContentView()
}
