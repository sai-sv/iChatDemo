//
//  ListViewController.swift
//  iChatDemo
//
//  Created by Admin on 11.03.2020.
//  Copyright © 2020 sergei. All rights reserved.
//

import UIKit

// MARK: - CollectionViewModel
struct ChatModel: Hashable, Decodable {
    var username: String
    var userImageString: String
    var lastMessage: String
    
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ChatModel, rhs: ChatModel) -> Bool {
        return lhs.id == rhs.id
    }
}

class ListViewController: UIViewController {
    
    private let activeChatasModel = Bundle.main.decode([ChatModel].self, from: "activeChats.json")
    private let waitingChatsModel = Bundle.main.decode([ChatModel].self, from: "waitingChats.json")
    
    enum CollectionViewSection: Int, CaseIterable {
        case WaitingChats, ActiveChats
    }
    
    private var collectionView: UICollectionView!
    private var collectionViewDataSource: UICollectionViewDiffableDataSource<CollectionViewSection, ChatModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        
        setupCollectionView()
        collectionViewItemData()
        reloadCollectionViewData()
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
        collectionView.register(ActiveChatCell.self, forCellWithReuseIdentifier: ActiveChatCell.id)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell2")
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
}

// MARK: - CollectionView Layout
extension ListViewController {
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            
            guard let section = CollectionViewSection(rawValue: sectionIndex) else { return nil }
            
            switch section {
            case .ActiveChats:
                return self.activeChatsSection()
            case .WaitingChats:
                return self.waitingChatsSection()
            }
        }
        return layout
    }
    
    private func waitingChatsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(88), heightDimension: .absolute(88))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20)
        section.interGroupSpacing = 20
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    private func activeChatsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(78))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20)
        section.interGroupSpacing = 20
        
        return section
    }
}

// MARK: - CollectionView Data Source
extension ListViewController {
    
    private func collectionViewItemData() {
        
        collectionViewDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView,
                                                                      cellProvider: { (collectionView, indexPath, itemData) -> UICollectionViewCell? in
            guard let section = CollectionViewSection(rawValue: indexPath.section) else { return nil }
            switch section {
            case .WaitingChats:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath)
                cell.backgroundColor = .systemTeal
                return cell
            case .ActiveChats:
                return self.configureCollectionViewCell(ActiveChatCell.self, with: itemData, by: indexPath)
            }
        })
    }
    
    private func reloadCollectionViewData() {
        var snapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, ChatModel>()
        snapshot.appendSections([.WaitingChats, .ActiveChats])
        snapshot.appendItems(waitingChatsModel, toSection: .WaitingChats)
        snapshot.appendItems(activeChatasModel, toSection: .ActiveChats)
        
        collectionViewDataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func configureCollectionViewCell<T: CollectionViewCellConfigureProtocol>(_ type: T.Type, with data: ChatModel, by indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type.id, for: indexPath) as? T else { fatalError("Fail") }
        cell.configure(with: data)
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function)
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
