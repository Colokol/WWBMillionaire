//
//  Bundle + Decodable.swift
//  Who Wants to Be a Millionaire
//
//  Created by Vasilii Pronin on 28.02.2024.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from filename: String) -> T {
        guard let json = url(forResource: filename, withExtension: nil) else {
            fatalError("Failed to locate \(filename) in bundle.")
        }
        do {
            let jsonData = try Data(contentsOf: json)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(T.self, from: jsonData)
            return result
        } catch {
            print("Failed to load and decode JSON with error: \(error)")
        }
        
        fatalError("Failed to decode from bundle.")
    }
}
