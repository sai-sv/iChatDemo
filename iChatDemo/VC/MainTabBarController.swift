//
//  MainTabBarController.swift
//  iChatDemo
//
//  Created by Admin on 11.03.2020.
//  Copyright © 2020 sergei. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let imgConfiguration = UIImage.SymbolConfiguration(weight: .medium)
        
        tabBar.tintColor = #colorLiteral(red: 0.5568627451, green: 0.3529411765, blue: 0.968627451, alpha: 1)
        viewControllers = [ generateNavigationController(viewController: ListViewController(),
                                                         title: "Conversation",
                                                         image: UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: imgConfiguration)),
                            generateNavigationController(viewController: PeopleViewController(),
                                                         title: "People",
                                                         image: UIImage(systemName: "person.2", withConfiguration: imgConfiguration))
        ]
    }
    
    private func generateNavigationController(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let nvc = UINavigationController(rootViewController: viewController)
        nvc.tabBarItem.title = title
        nvc.tabBarItem.image = image
        return nvc
    }
}

// MARK: - SwiftUI
import SwiftUI

struct MainTabBarVCProvider: PreviewProvider {
    typealias ProviderType = MainTabBarVCProvider
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
