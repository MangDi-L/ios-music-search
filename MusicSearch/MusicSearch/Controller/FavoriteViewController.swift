//
//  FavoriteViewController.swift
//  MusicSearch
//
//  Created by mangdi on 2/13/24.
//

import UIKit

final class FavoriteViewController: UIViewController {
    private lazy var favoriteTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var musicData: [Music] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        setupNavigationBar()
        setupAutoLayout()
        setupFavoriteTableView()
        setupMusicData()
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
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
        favoriteTableView.register(MainTableViewCell.self, forCellReuseIdentifier: Cell.favoriteTableViewCellIdentifier)
    }
    
    private func setupMusicData() {
        
    }
    
    private func setupAutoLayout() {
        [favoriteTableView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            favoriteTableView.topAnchor.constraint(equalTo: view.topAnchor),
            favoriteTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoriteTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.favoriteTableViewCellIdentifier, for: indexPath) as? MainTableViewCell ?? MainTableViewCell()
        cell.setupCellData(data: musicData[indexPath.row])
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .none:
            return
        case .delete:
            return
        case .insert:
            return
        @unknown default:
            return
        }
    }
}
