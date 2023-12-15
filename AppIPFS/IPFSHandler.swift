//
//  IPFSHandler.swift
//  AppIPFS
//
//  Created by busido on 04.12.2023.
//

import Foundation
import IPFSHandler

enum IPFSError: Error {
    case errorSavingImg
}

class IPFSManager {
    let handler: IPFSHandler
    
    static var shared = IPFSManager()
    
    init() {
        let settings = IPFSSettings(baseUrl: "http://127.0.0.1:5001/api/v0")
        self.handler = IPFSHandler(settings: settings)
    }
    
    func saveImgData(_ data: Data) async throws -> String? {
        let response = try await withCheckedThrowingContinuation { continuation in
            try? handler.add(data) { response, error in
                continuation.resume(returning: response)
            }
        }
        return response?.hash
    }
    
    func loadImgData(_ hash: String) async throws -> Data? {
        let response = try await withCheckedThrowingContinuation { continuation in
            handler.get(hashValue: hash) { response, error in
                continuation.resume(returning: response)
            }
        }
        return response?.decodedData
    }
}
