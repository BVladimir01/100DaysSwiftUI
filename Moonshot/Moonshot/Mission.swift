//
//  Mission.swift
//  Moonshot
//
//  Created by Vladimir on 03.12.2024.
//

import Foundation

struct Mission: Codable, Identifiable, Hashable {
    
    let id: Int
    let crew: [CrewMember]
    let description: String
    let launchDate: Date?
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var imageString: String {
        "apollo\(id)"
    }
    
    struct CrewMember: Codable, Hashable {
        let name: String
        let role: String
    }
}
