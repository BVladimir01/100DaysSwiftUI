//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Vladimir on 03.12.2024.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: "json") else {
            fatalError("Could not locate \(file) in bundle")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Coul not read data of \(file)")
        }
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        guard let decoded = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode data of \(file)")
        }
        return decoded
    }
}
