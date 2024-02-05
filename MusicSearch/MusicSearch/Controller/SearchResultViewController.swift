//
//  SearchResultViewController.swift
//  MusicSearch
//
//  Created by mangdi on 2/5/24.
//

import UIKit

final class SearchResultViewController: UIViewController {
    private lazy var searchResultCollectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAutoLayout()
        setupSearchResultCollectionView()
    }
    
    private func setupSearchResultCollectionView() {
        searchResultCollectionView.backgroundColor = .white
//        searchResultCollectionView.dataSource = self
        
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: UIConstants.defaultValue,
                                                           leading: UIConstants.defaultValue,
                                                           bottom: UIConstants.defaultValue,
                                                           trailing: UIConstants.defaultValue)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(0.4))
        let layoutGruop = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                             subitem: layoutItem,
                                                             count: 4)
        let layoutSection = NSCollectionLayoutSection(group: layoutGruop)
        let compositionalLayout = UICollectionViewCompositionalLayout(section: layoutSection)
        searchResultCollectionView.collectionViewLayout = compositionalLayout
    }
    
    private func setupAutoLayout() {
        view.addSubview(searchResultCollectionView)
        NSLayoutConstraint.activate([
            searchResultCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            searchResultCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchResultCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchResultCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
