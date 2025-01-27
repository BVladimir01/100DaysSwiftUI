//
//  ContentView.swift
//  Challenge60
//
//  Created by Vladimir on 27.01.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var users: [User] = []
    @State private var sortOrder = [SortDescriptor(\User.name), SortDescriptor(\User.age)]
    @State private var activityFilter: Set<Bool> = [false, true]
    
    func loadUsers() async {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedUsers = try decoder.decode([User].self, from: data)
            users = decodedUsers
        } catch {
            print(error.localizedDescription)
            users = []
        }
    }
    
    var body: some View {
        NavigationStack {
            UsersView(users: users, sortOrder: sortOrder, activityFilter: activityFilter)
            .navigationDestination(for: User.self) { user in
                DetailView(user: user)
            }
            .navigationTitle("Users")
            .toolbar {
                ToolbarItem(placement: .secondaryAction) {
                    filterToggler
                }
                ToolbarItem(placement: .primaryAction) {
                    sortingMenu
                }
            }
        }
        .task {
            await loadUsers()
        }
    }
    
    private var sortingMenu: some View {
        Menu("Sorting Order", systemImage: "arrow.up.arrow.down") {
            Picker("Sorting Order", selection: $sortOrder) {
                Text("Sort by default")
                    .tag([SortDescriptor(\User.id)])
                Text("Sort by name")
                    .tag([SortDescriptor(\User.name), SortDescriptor(\User.age)])
                Text("Sort by age").tag([SortDescriptor(\User.age), SortDescriptor(\User.name)])
            }
        }
    }
    
    private var filterToggler: some View {
        Toggle("Show active users only",
               isOn: Binding(get: { !activityFilter.contains(false) },
                             set: { isSelected in
            if isSelected {
                activityFilter.remove(false)
            } else {
                activityFilter.insert(false)
            }
        }
                            )
        )
    }
}

#Preview {
    ContentView()
}
