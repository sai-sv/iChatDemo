//
//  ChatModel.swift
//  iChatDemo
//
//  Created by Admin on 15.03.2020.
//  Copyright © 2020 sergei. All rights reserved.
//

import UIKit

struct ChatModel: Hashable, Decodable {
    var friendUsername: String
    var friendAvatarStringURL: String
    var lastMessage: String
    var friendId: String
    
    func representation() -> [String: Any] {
        let rep = ["friendName": friendUsername,
                   "friendAvatarURL": friendAvatarStringURL,
                   "lastMessage": lastMessage,
                   "friendId": friendId]
        return rep
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(friendId)
    }
    
    static func == (lhs: ChatModel, rhs: ChatModel) -> Bool {
        return lhs.friendId == rhs.friendId
    }
}
