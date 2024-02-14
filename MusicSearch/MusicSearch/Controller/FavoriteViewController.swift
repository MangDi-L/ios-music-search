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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        setupNavigationBar()
        setupAutoLayout()
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
