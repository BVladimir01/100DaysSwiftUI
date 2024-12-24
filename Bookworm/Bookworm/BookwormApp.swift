//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Vladimir on 24.12.2024.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Student.self, inMemory: false)
    }
}
