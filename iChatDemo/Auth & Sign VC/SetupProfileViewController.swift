//
//  SetupProfileViewController.swift
//  iChatDemo
//
//  Created by Admin on 10.03.2020.
//  Copyright © 2020 sergei. All rights reserved.
//

import UIKit

class SetupProfileViewController: UIViewController {
    
    private let titleLabel = UILabel(text: "Set up profile", font: .avenirFont(size: 26))
    private let userProfilePhotoView = UserProfilePhotoView()
    
    private let fullNameLabel = UILabel(text: "Full name")
    private let fullNameTextField = OneLineTextField(font: .avenirFont())
    
    private let aboutLabel = UILabel(text: "About me")
    private let aboutTextField = OneLineTextField(font: .avenirFont())
    
    private let genderLabel = UILabel(text: "Gender")
    private let genderControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "Male", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Female", at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private let goToChatsButton: UIButton = {
        let button = UIButton(title: "Go to chats!", titleColor: .whiteColor, backgroundColor: .blackColor)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        let fullNameStackView = UIStackView(subviews: [fullNameLabel, fullNameTextField], spacing: 0)
        let aboutStackView = UIStackView(subviews: [aboutLabel, aboutTextField], spacing: 0)
        let genderStackView = UIStackView(subviews: [genderLabel, genderControl], spacing: 12)
        let stackView = UIStackView(subviews: [fullNameStackView, aboutStackView, genderStackView, goToChatsButton])
    
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        userProfilePhotoView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        view.addSubview(userProfilePhotoView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.topPadding),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            userProfilePhotoView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            userProfilePhotoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: userProfilePhotoView.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding),
            goToChatsButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }
}


// MARK: - SwiftUI
import SwiftUI

struct SetupProfileVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = SetupProfileViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SetupProfileVCProvider.ContainerView>) -> SetupProfileViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: SetupProfileVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SetupProfileVCProvider.ContainerView>) {
        }
    }
}
