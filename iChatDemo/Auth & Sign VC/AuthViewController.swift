//
//  ViewController.swift
//  iChatDemo
//
//  Created by Admin on 08.03.2020.
//  Copyright © 2020 sergei. All rights reserved.
//

import UIKit

protocol AuthVCRoutingDelegate: class {
    func toSignUpVC()
    func toLoginVC()
}

class AuthViewController: UIViewController {

    private let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Logo"), contentMode: .scaleAspectFit)
    
    private let googleLabel = UILabel(text: "Get started with")
    private let emailLabel = UILabel(text: "Or sigh up with")
    private let loginLabel = UILabel(text: "Already onboard?")
    
    private let googleButton = UIButton(title: "Google", titleColor: .blackColor, backgroundColor: .whiteColor, isShadow: true)
    private let emailButton = UIButton(title: "Email", titleColor: .whiteColor, backgroundColor: .blackColor)
    private let loginButton = UIButton(title: "Login", titleColor: .redColor, backgroundColor: .whiteColor, isShadow: true)
    
    private let loginVC = LoginViewController()
    private let signUpVC = SignUpViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        googleButton.customizeGoogleButton()
        
        setupConstraints()
        
        emailButton.addTarget(self, action: #selector(emailButtonAction), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        
        loginVC.delegate = self
        signUpVC.delegate = self
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
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.topPadding),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 160),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding),
        ])
    }
    
    @objc func emailButtonAction() {
        present(signUpVC, animated: true, completion: nil)
    }
    
    @objc func loginButtonAction() {
        present(loginVC, animated: true, completion: nil)
    }
}

extension AuthViewController: AuthVCRoutingDelegate {
    func toSignUpVC() {
        self.present(signUpVC, animated: true, completion: nil)
    }
    
    func toLoginVC() {
        self.present(loginVC, animated: true, completion: nil)
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
