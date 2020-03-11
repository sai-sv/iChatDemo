//
//  SignUpViewController.swift
//  iChatDemo
//
//  Created by Admin on 10.03.2020.
//  Copyright © 2020 sergei. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let greetingLabel = UILabel(text: "Glad to see you", font: .avenirFont(size: 26))
    
    private let emailLabel = UILabel(text: "Email")
    private let passwordLabel = UILabel(text: "Password")
    private let confirmLabel = UILabel(text: "Confirm password")
    
    private let emailTextField = OneLineTextField(font: .avenirFont())
    private let passwordTextField = OneLineTextField(font: .avenirFont())
    private let confirmPasswordTextField = OneLineTextField(font: .avenirFont())
    
    private let signUpButton: UIButton = {
       let button = UIButton(title: "Sign up", titleColor: .whiteColor, backgroundColor: .blackColor)
        return button
    }()
    
    private let alreadyOnboardLabel = UILabel(text: "Already on board?")
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.redColor, for: .normal)
        button.titleLabel?.font = .avenirFont()
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        let emailStackView = UIStackView(subviews: [emailLabel, emailTextField], spacing: 0)
        let passwordStackView = UIStackView(subviews: [passwordLabel, passwordTextField], spacing: 0)
        let confirmPasswordStackView = UIStackView(subviews: [confirmLabel, confirmPasswordTextField], spacing: 0)
        let stackView = UIStackView(subviews: [emailStackView, passwordStackView, confirmPasswordStackView, signUpButton])
        
        let footerStackView = UIStackView(subviews: [alreadyOnboardLabel, loginButton], axis: .horizontal, spacing: 10)
        footerStackView.alignment = .firstBaseline
        
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        footerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(greetingLabel)
        view.addSubview(stackView)
        view.addSubview(footerStackView)
        
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.topPadding),
            greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding),
            signUpButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            
            footerStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 60),
            footerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
            footerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding)
        ])
    }
}

// MARK: - SwiftUI
import SwiftUI

struct SignUpVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = SignUpViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SignUpVCProvider.ContainerView>) -> SignUpViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: SignUpVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SignUpVCProvider.ContainerView>) {
        }
    }
}
