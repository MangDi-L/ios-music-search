//
//  SearchResultViewController.swift
//  MusicSearch
//
//  Created by mangdi on 2/5/24.
//

import UIKit

final class SearchResultViewController: UIViewController {
    lazy var searchResultCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeSearchResultCollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var musicData: [Music] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAutoLayout()
        setupSearchResultCollectionView()
    }
    
    func setupMusicData(search: String) {
        NetworkManager.shared.fetchMusicData(search: search) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                guard let data else { return }
                DispatchQueue.main.async {
                    guard let mainVC = self.presentingViewController as? MainViewController else { return }
                    self.musicData = mainVC.sortingMusicLatestDate(musics: data, isLatest: MainViewController.isActivateLatestButton)
                    self.searchResultCollectionView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("메인 ", error.rawValue)
                }
            }
        }
    }
    
    private func setupSearchResultCollectionView() {
        searchResultCollectionView.backgroundColor = .white
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.delegate = self
        searchResultCollectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: Cell.searchResultCollectionViewCellIdentifier)
    }
    
    // 상수 고치기
    private func makeSearchResultCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: UIConstants.defaultValue,
                                                           leading: UIConstants.defaultValue,
                                                           bottom: UIConstants.defaultValue,
                                                           trailing: UIConstants.defaultValue)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(0.2))
        let layoutGruop = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                             subitem: layoutItem,
                                                             count: 3)
        let layoutSection = NSCollectionLayoutSection(group: layoutGruop)
        let compositionalLayout = UICollectionViewCompositionalLayout(section: layoutSection)
        return compositionalLayout
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

extension SearchResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.searchResultCollectionViewCellIdentifier, for: indexPath) as? SearchResultCollectionViewCell ?? SearchResultCollectionViewCell()
        cell.setupCellData(data: musicData[indexPath.item])
        return cell
    }
}

extension SearchResultViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.musicData = musicData[indexPath.row]
        presentingViewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
