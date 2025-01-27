//
//  DetailView.swift
//  Challenge60
//
//  Created by Vladimir on 27.01.2025.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    
    var user: User
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(String(user.age))
                    .font(.title)
                Text(user.address)
                    .font(.headline)
                    .padding(.bottom, 10)
                Text(user.about)
                    .font(.headline)
            }
            .padding()
        }
        .navigationTitle(user.name)
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let modelContainer = try ModelContainer(for: User.self, configurations: config)
        let user = User(id: "gsdhjljla", isActive: true, name: "Dave", age: 40, company: "company", email: "lmao@gmail.com", address: "London", about: "info about me", registered: .now, tags: [], friends: [])
        return DetailView(user: user)
            .modelContainer(modelContainer)
    } catch {
        return Text(error.localizedDescription)
    }
}
