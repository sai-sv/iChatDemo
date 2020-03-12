//
//  WaitingChatCell.swift
//  iChatDemo
//
//  Created by Admin on 12.03.2020.
//  Copyright © 2020 sergei. All rights reserved.
//

import UIKit

class WaitingChatCell: UICollectionViewCell {
    
    private let photoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 4
        clipsToBounds = true
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(photoImageView)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension WaitingChatCell: CollectionViewCellConfigureProtocol {
    static var id = "WaitingChatCell"
    
    func configure(with data: ChatModel) {
        photoImageView.image = UIImage(named: data.userImageString)
    }
}

// MARK: - SwiftUI
import SwiftUI

struct WaitingChatCellProvider: PreviewProvider {
    typealias ProviderType = WaitingChatCellProvider
    typealias VCType = MainTabBarController
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = VCType()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ProviderType.ContainerView>) -> VCType {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: ProviderType.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProviderType.ContainerView>) {
        }
    }
}


