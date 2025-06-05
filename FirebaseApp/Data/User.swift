//
//  User.swift
//  FirebaseApp
//
//  Created by Mañanas on 5/6/25.
//

import Foundation

struct User: Codable {
    var id: String
    var username: String
    var firstName: String
    var lastName: String
    var gender: Gender
    var birthday: Date?
    var provider: LoginProvider
    
}

enum Gender: String, Codable {
    case male
    case female
    case other
    case unespecified
}

enum LoginProvider: String, Codable {
    case google
    case github
    case facebook
    case apple
    
}
