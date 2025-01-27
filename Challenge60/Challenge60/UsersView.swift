//
//  UsersView.swift
//  Challenge60
//
//  Created by Vladimir on 27.01.2025.
//

import SwiftUI

struct UsersView: View {
    
    var users: [User]
    
    var body: some View {
        List {
            ForEach(users) { user in
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
    
    init(users: [User], sortOrder: [SortDescriptor<User>], activityFilter: Set<Bool>) {
        let sortedUsers = users.sorted(using: sortOrder)
        let filteredUsers = sortedUsers.filter({activityFilter.contains($0.isActive)})
        self.users = filteredUsers
    }
}

//#Preview {
//    UsersView(users: [])
//}
