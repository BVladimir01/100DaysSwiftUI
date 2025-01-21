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
    
    var body: some View {
        NavigationStack(path: $path) {
            List(users) { user in
                NavigationLink(value: user) {
                    Text(user.name)
                }
            }
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
                UserEditView(for: user)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add user", systemImage: "plus") {
                        let user = User(name: "", city: "")
                        modelContext.insert(user)
                        path.append(user)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
