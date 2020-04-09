//
//  FirestoreService.swift
//  iChatDemo
//
//  Created by Admin on 26.03.2020.
//  Copyright © 2020 sergei. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FirestoreService {
    
    static let shared = FirestoreService()
    
    private let db = Firestore.firestore()
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    private var currentUser: UserModel!
    
    func saveProfile(id: String, email: String, username: String?, gender: String?, description: String?, avatarImage: UIImage?,
                     completion: @escaping (Result<UserModel, Error>) -> Void) {
        
        guard Validators.isFilled(username: username, gender: gender, description: description) else {
            completion(.failure(UserError.notFilled))
            return
        }
        
        guard let photo = avatarImage, photo != #imageLiteral(resourceName: "avatar") else {
            completion(.failure(UserError.photoNotExist))
            return
        }
        
        var userModel = UserModel(id: id,
                             email: email,
                             username: username!,
                             gender: gender!,
                             description: description!,
                             avatarStringURL: "no photo")
        
        StorageService.shared.upload(image: photo) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let photoURL):
                userModel.avatarStringURL = photoURL.absoluteString
                
                self.usersRef.document(userModel.id).setData(userModel.representation()) { (error) in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(userModel))
                    }
                }
            }
        } // StorageService upload
    }
    
    func getUserProfile(user: User, completion: @escaping (Result<UserModel, Error>) -> Void) {
        
        let userDocRref = usersRef.document(user.uid)
        userDocRref.getDocument { (docSnapshot, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let snapshot = docSnapshot, snapshot.exists else {
                completion(.failure(UserError.profileNotExist))
                return
            }
            
            guard let userModel = UserModel(document: snapshot) else {
                completion(.failure(UserError.documentConversionFailed))
                return
            }
            self.currentUser = userModel
            completion(.success(userModel))
        }
    }
    
    func chatRequest(message: String, receiverUser: UserModel, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let waitingChatsRef = db.collection(["users", receiverUser.id, "waitingChats"].joined(separator: "/"))
        let messagesRef = waitingChatsRef.document(currentUser.id).collection("messages")
        
        let messageModel = MessageModel(user: currentUser, content: message)
        
        let chatModel = ChatModel(friendUsername: currentUser.username,
                             friendAvatarStringURL: currentUser.avatarStringURL,
                             lastMessage: messageModel.content,
                             friendId: currentUser.id)
        waitingChatsRef.document(currentUser.id).setData(chatModel.representation()) { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            messagesRef.addDocument(data: messageModel.representation()) { (error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(Void()))
            }
        }
        
        
    }
}
