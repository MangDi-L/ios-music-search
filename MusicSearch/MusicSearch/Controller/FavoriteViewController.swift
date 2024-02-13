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
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        [favoriteTableView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            favoriteTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIConstants.defaultValue),
            favoriteTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.defaultValue),
            favoriteTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: UIConstants.defaultValue),
            favoriteTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: UIConstants.defaultValue)
        ])
    }
}
