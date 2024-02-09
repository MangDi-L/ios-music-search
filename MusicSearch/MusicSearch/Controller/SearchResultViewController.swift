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
    var collectionViewBottomConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAutoLayout()
        setupSearchResultCollectionView()
        setupKeyboardNotification()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        navigationItem.searchController?.searchBar.endEditing(true)
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
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(UIConstants.defalutMultiplier),
                                                heightDimension: .fractionalHeight(UIConstants.defalutMultiplier))
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: UIConstants.defaultValue,
                                                           leading: UIConstants.defaultValue,
                                                           bottom: UIConstants.defaultValue,
                                                           trailing: UIConstants.defaultValue)
        let groupHight = view.frame.height / Number.fourPointFive
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(UIConstants.defalutMultiplier),
                                               heightDimension: .absolute(groupHight))
        let layoutGruop = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                             subitem: layoutItem,
                                                             count: Number.three)
        let layoutSection = NSCollectionLayoutSection(group: layoutGruop)
        let compositionalLayout = UICollectionViewCompositionalLayout(section: layoutSection)
        return compositionalLayout
    }
    
    private func setupKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardMoveUpAction), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardMoveDownAction), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupAutoLayout() {
        [searchResultCollectionView].forEach { view.addSubview($0) }
        
        collectionViewBottomConstraint = searchResultCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        collectionViewBottomConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            searchResultCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIConstants.highValue),
            searchResultCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchResultCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchResultCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func keyboardMoveUpAction(notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            collectionViewBottomConstraint?.constant = -keyboardHeight
            UIView.animate(withDuration: AnimationTimeConstants.basic) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardMoveDownAction(notification: Notification) {
        collectionViewBottomConstraint?.constant = .zero
        UIView.animate(withDuration: AnimationTimeConstants.basic) {
            self.view.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
