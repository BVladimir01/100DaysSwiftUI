//
//  Challenge60App.swift
//  Challenge60
//
//  Created by Vladimir on 27.01.2025.
//

import SwiftUI

@main
struct Challenge60App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
