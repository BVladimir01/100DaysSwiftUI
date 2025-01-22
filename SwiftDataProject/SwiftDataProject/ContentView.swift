//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Vladimir on 21.01.2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Query(filter: #Predicate<User> { user in
        user.name.contains("R")
    },
           sort: [SortDescriptor(\User.name), SortDescriptor(\User.joinDate, order: .reverse)]) var users: [User]
    @Environment(\.modelContext) var modelContext
    
    @State private var path = [User]()
    @State private var showFutureOnly = false
    @State private var sortOrder = [SortDescriptor(\User.joinDate), SortDescriptor(\User.name)]
    
    var body: some View {
        NavigationStack(path: $path) {
            UsersView(minimumJoinDate: showFutureOnly ? .now : .distantPast, sortOrder: sortOrder)
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
                UserEditView(for: user)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add user", systemImage: "plus") {
                        let user = User(name: "", city: "")
                        modelContext.insert(user)
                        path.append(user)
                        addJobs()
                    }
                }
                ToolbarItem(placement: .secondaryAction) {
                    Button(showFutureOnly ? "Show all users" : "Show future users") {
                        showFutureOnly.toggle()
                    }
                }
                ToolbarItem(placement: .secondaryAction) {
                    Menu("Sort order", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort order", selection: $sortOrder) {
                            Text("Sort by join date")
                                .tag([SortDescriptor(\User.joinDate), SortDescriptor(\User.name)])
                            Text("Sort by name")
                                .tag([SortDescriptor(\User.name),
                                      SortDescriptor(\User.joinDate)])
                        }
                    }
                }
            }
        }
    }
    
    private func addJobs() {
        let user = User(name: "Working User", city: "London")
        let job1 = Job(name: "Dev", priority: 1)
        let job2 = Job(name: "Athlete", priority: 2)
        modelContext.insert(user)
        user.jobs.append(job1)
        user.jobs.append(job2)
    }
}

#Preview {
    ContentView()
}
