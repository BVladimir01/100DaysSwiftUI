//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Vladimir on 21.01.2025.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [User.self, Job.self])
    }
}
