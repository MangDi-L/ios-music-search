//
//  FavoriteViewController.swift
//  MusicSearch
//
//  Created by mangdi on 2/13/24.
//

import UIKit

final class FavoriteViewController: UIViewController {
    private lazy var favoriteMusicTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var favoriteMusicData: [FavoriteMusic] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        setupNavigationBar()
        setupAutoLayout()
        setupFavoriteTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFavoriteMusicData()
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemGray6
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        title = NavigationBarText.secondTitle
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func setupFavoriteTableView() {
        favoriteMusicTableView.dataSource = self
        favoriteMusicTableView.delegate = self
        favoriteMusicTableView.register(MainTableViewCell.self, forCellReuseIdentifier: Cell.favoriteTableViewCellIdentifier)
    }
    
    private func setupFavoriteMusicData() {
        favoriteMusicData = CoreDataManager.shared.fetchFavoriteMusics()
        favoriteMusicTableView.reloadData()
    }
    
    private func setupAutoLayout() {
        [favoriteMusicTableView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            favoriteMusicTableView.topAnchor.constraint(equalTo: view.topAnchor),
            favoriteMusicTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteMusicTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoriteMusicTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMusicData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.favoriteTableViewCellIdentifier, for: indexPath) as? FavoriteTableViewCell ?? FavoriteTableViewCell()
        cell.setupCellData(data: favoriteMusicData[indexPath.row])
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .none:
            return
        case .delete:
            CoreDataManager.shared.deleteFavoriteMusic(favoriteMusic: favoriteMusicData[indexPath.row])
            setupFavoriteMusicData()
        case .insert:
            return
        @unknown default:
            return
        }
    }
}
