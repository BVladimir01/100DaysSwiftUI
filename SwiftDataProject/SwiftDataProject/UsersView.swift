//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Vladimir on 22.01.2025.
//

import SwiftData
import SwiftUI

struct UsersView: View {
    
    @Query var users: [User]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        List {
            ForEach(users) { user in
                NavigationLink(value: user) {
                    Text(user.name)
                    Spacer(minLength: 20)
                    Text(user.jobs.count.description)
                        .fontWeight(.black)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.circle)
                    Spacer()
                }
            }
            .onDelete(perform: delete)
        }
    }
    
    private func delete(at indicies: IndexSet) {
        for index in indicies {
            let user = users[index]
            modelContext.delete(user)
        }
    }
    
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minimumJoinDate
        }, sort: sortOrder)
    }
}

#Preview {
    UsersView(minimumJoinDate: .distantPast, sortOrder: [SortDescriptor(\User.joinDate)])
        .modelContainer(for: User.self)
}
