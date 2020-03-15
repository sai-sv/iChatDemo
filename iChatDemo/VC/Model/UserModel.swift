//
//  UserModel.swift
//  iChatDemo
//
//  Created by Admin on 15.03.2020.
//  Copyright © 2020 sergei. All rights reserved.
//

import UIKit

struct UserModel: Hashable, Decodable {
    var username: String
    var avatarStringURL: String
    
    var id: Int
    
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
