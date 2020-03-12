//
//  ListViewController.swift
//  iChatDemo
//
//  Created by Admin on 11.03.2020.
//  Copyright © 2020 sergei. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupCollectionView()
    }
    
    private func setupSearchBar() {
        navigationController?.navigationBar.barTintColor = .whiteColor
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let searchBarController = UISearchController(searchResultsController: nil)
        searchBarController.hidesNavigationBarDuringPresentation = true
        searchBarController.obscuresBackgroundDuringPresentation = true
        searchBarController.searchBar.delegate = self
        
        navigationItem.searchController = searchBarController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func setupCollectionView() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout())
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "FlowLayoutCell")
        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .whiteColor
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(84))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20)
            
            return section
        }
        return layout
    }
}

// MARK: - UISearchBarDelegate
extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlowLayoutCell", for: indexPath)
        cell.backgroundColor = .red
        cell.layer.borderWidth = 1
        return cell
    }
}


// MARK: - SwiftUI
import SwiftUI

struct ListVCProvider: PreviewProvider {
    typealias ProviderType = ListVCProvider
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
