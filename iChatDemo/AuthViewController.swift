//
//  ViewController.swift
//  iChatDemo
//
//  Created by Admin on 08.03.2020.
//  Copyright © 2020 sergei. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    private let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Logo"), contentMode: .scaleAspectFit)
    
    private let googleLabel = UILabel(text: "Get started with")
    private let emailLabel = UILabel(text: "Or sigh up with")
    private let loginLabel = UILabel(text: "Already onboard?")
    
    private let googleButton = UIButton(title: "Google", titleColor: .blackColor, backgroundColor: .whiteColor, isShadow: true)
    private let emailButton = UIButton(title: "Email", titleColor: .whiteColor, backgroundColor: .blackColor)
    private let loginButton = UIButton(title: "Login", titleColor: .redColor, backgroundColor: .whiteColor, isShadow: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        let googleButtonView = ButtonWithLabelView(label: googleLabel, button: googleButton)
        let emailButtonView = ButtonWithLabelView(label: emailLabel, button: emailButton)
        let loginButtonView = ButtonWithLabelView(label: loginLabel, button: loginButton)
        let stackView = UIStackView(subviews: [googleButtonView, emailButtonView, loginButtonView])
        
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 160),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding),
        ])
    }
}

// MARK: - SwiftUI
import SwiftUI

struct AuthVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {

        let viewController = AuthViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<AuthVCProvider.ContainerView>) -> AuthViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: AuthVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<AuthVCProvider.ContainerView>) {
        }
    }
}
