//
//  ProfileViewController.swift
//  iChatDemo
//
//  Created by Admin on 16.03.2020.
//  Copyright © 2020 sergei. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var imageView = UIImageView(image: #imageLiteral(resourceName: "human10"), contentMode: .scaleAspectFill)
    private var usernameLabel = UILabel(text: "Ariana Grande", font: .systemFont(ofSize: 20, weight: .medium))
    private var aboutMeLabel = UILabel(text: "American singer, songwriter and actress", font: .systemFont(ofSize: 16, weight: .light))
    private var textField = UITextField()
    private var containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutMeLabel.numberOfLines = 0
        textField.borderStyle = .roundedRect
        containerView.layer.cornerRadius = 30
        containerView.clipsToBounds = true
        containerView.backgroundColor = .whiteColor
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutMeLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        view.addSubview(containerView)
        containerView.addSubview(usernameLabel)
        containerView.addSubview(aboutMeLabel)
        containerView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 206),
            
            usernameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 35),
            usernameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            aboutMeLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            aboutMeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            aboutMeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            textField.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 16),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            textField.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
}

// MARK: - SwiftUI
import SwiftUI

struct ProfileVCProvider: PreviewProvider {
    typealias ProviderType = ProfileVCProvider
    typealias VCType = ProfileViewController
    
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
