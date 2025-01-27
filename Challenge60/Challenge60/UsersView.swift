//
//  UsersView.swift
//  Challenge60
//
//  Created by Vladimir on 27.01.2025.
//

import SwiftData
import SwiftUI

struct UsersView: View {
    
    @Query var users: [User]
    private var filteredUsers: [User] {
        users.filter({activityFilter.contains($0.isActive)})
    }
    private var activityFilter: Set<Bool>
    
    var body: some View {
        List {
            ForEach(filteredUsers) { user in
                NavigationLink(value: user) {
                    HStack(spacing: 10) {
                        Text(user.name)
                            .font(.title3)
                        Text(user.age.description)
                            .font(.caption)
                    }
                }
            }
        }
    }
    
    init(sortOrder: [SortDescriptor<User>], activityFilter: Set<Bool>) {
        self._users = Query(sort: sortOrder)
        self.activityFilter = activityFilter
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let modelContainer = try ModelContainer(for: User.self, configurations: config)
        return UsersView(sortOrder: [SortDescriptor(\User.id)], activityFilter: Set([true, false]))
            .modelContainer(modelContainer)
    } catch {
        return Text(error.localizedDescription)
    }
}
