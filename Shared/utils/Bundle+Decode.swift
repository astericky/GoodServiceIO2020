//
//  Bundle+Decode.swift
//  iOS
//
//  Created by Chris Sanders on 7/8/20.
//  Hacking with Swift Useful Extensions
//  - https://www.hackingwithswift.com/articles/141/8-useful-swift-extensions

import Foundation

enum BundleLoadingError: Error {
    case assetMissingError(String)
    case fileLoadingError(String)
    case decodingError(String)
}

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from filename: String) throws -> T {
        guard let url = url(forResource: filename, withExtension: nil) else {
            throw BundleLoadingError.assetMissingError("Failed to locate \(filename) in app bundle.")
        }
        
        guard let jsonData = try? Data(contentsOf: url) else {
            throw BundleLoadingError.fileLoadingError("Failed to load \(filename) from app bundle.")
        }

        let decoder = JSONDecoder()
        
        guard let result = try? decoder.decode(T.self, from: jsonData) else {
            throw BundleLoadingError.decodingError("Failed to decode \(filename) from app bundle.")
        }

        return result
    }
    
    func convertToJSON(from filename: String) throws -> [String: Any] {
        guard let url = url(forResource: filename, withExtension: nil) else {
            throw BundleLoadingError.assetMissingError("Failed to locate \(filename) in app bundle.")
        }
        
        guard let jsonData = try? Data(contentsOf: url) else {
            throw BundleLoadingError.fileLoadingError("Failed to load \(filename) from app bundle.")
        }
        
//        guard let jsonString = try String(data: jsonData, encoding: .utf8) else {
//            throw BundleLoadingError.decodingError("Failed to decode \(filename) from app bundle.")
//        }
        
        return try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] ?? [:]
    }
}
