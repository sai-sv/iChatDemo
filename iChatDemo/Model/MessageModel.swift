//
//  MessageModel.swift
//  iChatDemo
//
//  Created by Admin on 05.04.2020.
//  Copyright © 2020 sergei. All rights reserved.
//

import UIKit
import FirebaseFirestore

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
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let senderName = data["senderName"] as? String,
            let sentDate = data["sentDate"] as? Timestamp,
            let content = data["content"] as? String,
            let senderId = data["senderId"] as? String else {
                return nil
        }
        self.senderName = senderName
        self.sentDate = sentDate.dateValue()
        self.content = content
        self.senderId = senderId
    }
    
    func representation() -> [String: Any] {
        return ["senderName": senderName,
                "sentDate": sentDate,
                "content": content,
                "senderId": senderId]
    }
}
