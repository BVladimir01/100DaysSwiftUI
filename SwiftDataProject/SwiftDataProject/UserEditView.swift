//
//  UserEditView.swift
//  SwiftDataProject
//
//  Created by Vladimir on 21.01.2025.
//

import SwiftData
import SwiftUI

struct UserEditView: View {
    
    @Bindable var user: User
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            TextField("User's name", text: $user.name)
            TextField("User's city", text: $user.city)
            DatePicker("JoinDate", selection: $user.joinDate, displayedComponents: .date)
        }
        .toolbar {
            ToolbarItem {
                Button("Confirm") { dismiss() }
            }
        }
    }
    
    init(for user: User) {
        self.user = user
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let modelContainer = try ModelContainer(for: User.self, configurations: config)
        return UserEditView(for: User(name: "", city: ""))
            .modelContainer(modelContainer)
    } catch {
        return Text(error.localizedDescription)
    }
}
