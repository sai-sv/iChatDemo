//
//  MessageModel.swift
//  iChatDemo
//
//  Created by Admin on 05.04.2020.
//  Copyright © 2020 sergei. All rights reserved.
//

import UIKit

struct MessageModel {
    var senderName: String
    var sentDate: Date
    var content: String
    var senderId: String
    
    init(user: UserModel, content: String) {
        senderName = user.username
        sentDate = Date()
        self.content = content
        senderId = user.id
    }
    
    func representation() -> [String: Any] {
        return ["senderName": senderName,
                "sentDate": sentDate,
                "content": content,
                "senderId": senderId]
    }
}
