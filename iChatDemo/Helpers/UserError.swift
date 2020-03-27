//
//  UserError.swift
//  iChatDemo
//
//  Created by Admin on 27.03.2020.
//  Copyright © 2020 sergei. All rights reserved.
//

import Foundation

enum UserError {
    case notFilled
    case photoNotExist
    case profileNotExist
    case documentConversionFailed
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Заполните все поля", comment: "")
        case .photoNotExist:
            return NSLocalizedString("Добавьте фотографию", comment: "")
        case .profileNotExist:
            return NSLocalizedString("Профиль не найден", comment: "")
        case .documentConversionFailed:
            return NSLocalizedString("Ошибка конвертации модели пользователя", comment: "")
        }
    }
}
