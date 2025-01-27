//
//  DetailView.swift
//  Challenge60
//
//  Created by Vladimir on 27.01.2025.
//

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
                    .padding(.bottom, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
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
    DetailView(user: User(id: "123", isActive: true, name: "LMao", age: 13, company: "company", email: "dfgs.com", address: "London", about: "my info", registered: .now, tags: [], friends: []))
}
