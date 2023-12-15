//
//  HashStorage.swift
//  AppIPFS
//
//  Created by busido on 04.12.2023.
//

import Foundation

class HashStorage {
    var userDefaults = UserDefaults.standard
    let hashKey = "\(UUID().uuidString)"
    
    static var shared = HashStorage()
    
    init() { }
    
    func saveHash(_ hash: String?) {
        guard (hash != nil) else {
            return
        }
        var currentArr = userDefaults.array(forKey: hashKey) as? [String]
        if let _ = currentArr {
            currentArr!.append(hash!)
            userDefaults.set(currentArr, forKey: hashKey)
        } else {
            userDefaults.set([hash], forKey: hashKey)
        }
    }
    
    func getHashes() -> [HashObject] {
        let strArr = userDefaults.array(forKey: hashKey) as? [String] ?? []
        var hashObjs: [HashObject] = []
        
        for (index, string) in strArr.enumerated() {
            hashObjs.append(HashObject(id: index, hash: string))
        }
        return hashObjs
    }
}

struct HashObject: Hashable, Codable, Identifiable {
    let id: Int
    let hash: String
}
