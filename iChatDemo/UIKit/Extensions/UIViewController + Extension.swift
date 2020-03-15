//
//  UIViewController + Extension.swift
//  iChatDemo
//
//  Created by Admin on 15.03.2020.
//  Copyright © 2020 sergei. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func collectionViewCell<T: CollectionViewCellProtocol, U: Hashable>(_ collectionView: UICollectionView, type: T.Type, with data: U, by indexPath: IndexPath) -> T? {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: T.id, for: indexPath) as? T else {
            return nil
        }
        cell.configure(with: data)
        return cell
    }
}
