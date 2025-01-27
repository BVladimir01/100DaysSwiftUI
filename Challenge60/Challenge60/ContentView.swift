//
//  ContentView.swift
//  Challenge60
//
//  Created by Vladimir on 27.01.2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    static let defaultSortOrder = [SortDescriptor(\User.name), SortDescriptor(\User.age)]
    
    @Query(sort: defaultSortOrder) private var users: [User] = []
    @Environment(\.modelContext) private var modelContext
    
    @State private var sortOrder = defaultSortOrder {
        didSet {
            save()
        }
    }
    @State private var activityFilter: Set<Bool> = [false, true] {
        didSet {
            save()
        }
    }
    
    func loadUsers() async {
        guard users.isEmpty else { return }
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedUsers = try decoder.decode([User].self, from: data)
            for user in decodedUsers {
                modelContext.insert(user)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        NavigationStack {
            UsersView(sortOrder: sortOrder, activityFilter: activityFilter)
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
                ToolbarItem(placement: .topBarLeading) {
                    deleteButton
                }
                ToolbarItem(placement: .secondaryAction) {
                    reloadButton
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
    
    private var deleteButton: some View {
        Button("Delete data", systemImage: "trash") {
            try? modelContext.delete(model: User.self)
        }
    }
    
    private var reloadButton: some View {
        Button("Reload data", systemImage: "arrow.clockwise") {
            Task {
                await loadUsers()
            }
        }
    }
    
    private enum SettingsKeys: String {
        case sortOrderKey, activityFilterKey
    }
    
    private func save() {
        let storage = UserDefaults.standard
        if let sortOrderData = try? JSONEncoder().encode(sortOrder) {
            storage.set(sortOrderData, forKey: SettingsKeys.sortOrderKey.rawValue)
        }
        if let activityFilterData = try? JSONEncoder().encode(activityFilter) {
            storage.set(activityFilterData, forKey: SettingsKeys.activityFilterKey.rawValue)
        }
    }
    
    init() {
        let storage = UserDefaults.standard
        if let sortOrderData = storage.data(forKey: SettingsKeys.sortOrderKey.rawValue) {
            if let sortOrder = try? JSONDecoder().decode([SortDescriptor<User>].self, from: sortOrderData) {
                self.sortOrder = sortOrder
            }
        }
        if let activityFilterData = storage.data(forKey: SettingsKeys.activityFilterKey.rawValue) {
            if let activityFilter = try? JSONDecoder().decode(Set<Bool>.self, from: activityFilterData) {
                self.activityFilter = activityFilter
            }
        }
    }
}

#Preview {
    ContentView()
}
