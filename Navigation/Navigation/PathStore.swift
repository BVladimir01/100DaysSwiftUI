//
//  PathStore.swift
//  Navigation
//
//  Created by Vladimir on 10.12.2024.
//

import SwiftUI


@Observable
class PathStore {
    var path: NavigationPath {
        didSet {
            save()
        }
    }
    
    init() {
        if let pathData = UserDefaults.standard.data(forKey: pathKey) {
            if let representation = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: pathData) {
                path = NavigationPath(representation)
                return
            } else {
                print("could not decode path representation")
            }
        } else {
            print("Could not locate 'storedPath'")
        }
        path = NavigationPath()
    }
    
    private func save() {
        guard let representation = path.codable else {
            print("some element of path is not codable")
            return
        }
        do {
            let data = try JSONEncoder().encode(representation)
            UserDefaults.standard.set(data, forKey: pathKey)
        } catch {
            print("could not encode path representation")
        }
    }
    
    private let pathKey = "storedPath"
}
