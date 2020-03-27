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
    
    func saveProfile(id: String, email: String, username: String?, gender: String?, description: String?, avatarURL: String?,
                     completion: @escaping (Result<UserModel, Error>) -> Void) {
        
        guard Validators.isFilled(username: username, gender: gender, description: description) else {
            completion(.failure(UserError.notFilled))
            return
        }
        
        let user = UserModel(id: id,
                             email: email,
                             username: username!,
                             gender: gender!,
                             description: description!,
                             avatarStringURL: "no photo")
        
        usersRef.document(user.id).setData(user.representation()) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
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
            completion(.success(userModel))
        }
    }
}
