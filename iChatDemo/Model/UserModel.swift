//
//  UserModel.swift
//  iChatDemo
//
//  Created by Admin on 15.03.2020.
//  Copyright © 2020 sergei. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct UserModel: Hashable, Decodable {
    var id: String
    var email: String
    var username: String
    var gender: String
    var description: String
    var avatarStringURL: String
    
    init?(document: DocumentSnapshot) { // try init from Firebase DocumentSnapshot
        guard let data = document.data(),
            let id = data["uid"] as? String,
            let email = data["email"] as? String,
            let username = data["username"] as? String,
            let gender = data["gender"] as? String,
            let description = data["description"] as? String,
            let avatarURL = data["avatarURL"] as? String else {
                return nil
        }
        self.id = id
        self.email = email
        self.username = username
        self.gender = gender
        self.description = description
        self.avatarStringURL = avatarURL
    }
    
    init?(document: QueryDocumentSnapshot) { // try init from Firebase QueryDocumentSnapshot
        let data = document.data()
        guard let id = data["uid"] as? String,
            let email = data["email"] as? String,
            let username = data["username"] as? String,
            let gender = data["gender"] as? String,
            let description = data["description"] as? String,
            let avatarURL = data["avatarURL"] as? String else {
                return nil
        }
        self.id = id
        self.email = email
        self.username = username
        self.gender = gender
        self.description = description
        self.avatarStringURL = avatarURL
    }
    
    init(id: String, email: String, username: String, gender: String, description: String, avatarStringURL: String) {
        self.id = id
        self.email = email
        self.username = username
        self.gender = gender
        self.description = description
        self.avatarStringURL = avatarStringURL
    }
    
    func representation() -> [String: Any] {
        return ["uid": id,
                "email": email,
                "username": username,
                "description": description,
                "gender": gender,
                "avatarURL": avatarStringURL]
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter else { return true }
        if filter.isEmpty { return true }
        let lowercasedFilter = filter.lowercased()
        return username.lowercased().contains(lowercasedFilter)
    }
}
