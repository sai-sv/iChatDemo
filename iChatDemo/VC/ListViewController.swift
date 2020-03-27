//
//  ListViewController.swift
//  iChatDemo
//
//  Created by Admin on 11.03.2020.
//  Copyright © 2020 sergei. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    private let activeChatasModel: [ChatModel] = [] // = Bundle.main.decode([ChatModel].self, from: "activeChats.json")
    private let waitingChatsModel: [ChatModel] = [] // = Bundle.main.decode([ChatModel].self, from: "waitingChats.json")
    
    private var currentUser: UserModel
    
    init(currentUser: UserModel) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum CollectionViewSection: Int, CaseIterable {
        case WaitingChats, ActiveChats
        
        func description() -> String {
            switch self {
            case .WaitingChats:
                return "Waiting chats"
            case .ActiveChats:
                return "Active chats"
            }
        }
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
        collectionView.register(WaitingChatCell.self, forCellWithReuseIdentifier: WaitingChatCell.id)
        collectionView.register(CollectionViewSectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: CollectionViewSectionHeader.reuseId)
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
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        
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
        
        let headerSection = createHeaderSection()
        section.boundarySupplementaryItems = [headerSection]
        
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
        
        let headerSection = createHeaderSection()
        section.boundarySupplementaryItems = [headerSection]
        
        return section
    }
    
    private func createHeaderSection() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let headerSection = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: size, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return headerSection
    }
}

// MARK: - CollectionView Data Source
extension ListViewController {
    
    private func collectionViewItemData() {
        
        // items
        collectionViewDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView,
                                                                      cellProvider: { (collectionView, indexPath, itemData) -> UICollectionViewCell? in
            guard let section = CollectionViewSection(rawValue: indexPath.section) else { fatalError("Unknown section kind") }
            switch section {
            case .WaitingChats:
                return self.collectionViewCell(collectionView, type: WaitingChatCell.self, with: itemData, by: indexPath)
            case .ActiveChats:
                return self.collectionViewCell(collectionView, type: ActiveChatCell.self, with: itemData, by: indexPath)
            }
        })
        
        // header
        collectionViewDataSource?.supplementaryViewProvider = {
            (collectionView, kind, indexPath) in
            
            guard let headerSection = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewSectionHeader.reuseId, for: indexPath) as? CollectionViewSectionHeader else {
                fatalError("Unknown section")
            }
            guard let section = CollectionViewSection(rawValue: indexPath.section) else { fatalError("Unknown section") }
            headerSection.configure(title: section.description(), font: .laoSangmanFont(), textColor: .systemGray)
            
            return headerSection
        }
    }
    
    private func reloadCollectionViewData() {
        var snapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, ChatModel>()
        snapshot.appendSections([.WaitingChats, .ActiveChats])
        snapshot.appendItems(waitingChatsModel, toSection: .WaitingChats)
        snapshot.appendItems(activeChatasModel, toSection: .ActiveChats)
        
        collectionViewDataSource?.apply(snapshot, animatingDifferences: true)
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
