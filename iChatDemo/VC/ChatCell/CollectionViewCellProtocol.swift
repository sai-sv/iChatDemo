//
//  CollectionViewCellProtocol.swift
//  iChatDemo
//
//  Created by Admin on 12.03.2020.
//  Copyright © 2020 sergei. All rights reserved.
//

import Foundation

protocol CollectionViewCellConfigureProtocol {
    static var id: String { get }
    func configure(with data: ChatModel)
}
