//
//  Friend.swift
//  Friends
//
//  Created by ke on 11/1/24.
//

import Foundation

struct User: Codable {
    struct Friend: Codable {
        var id: UUID
        var name: String
    }
    
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
}
