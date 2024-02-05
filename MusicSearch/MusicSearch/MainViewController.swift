//
//  ViewController.swift
//  MusicSearch
//
//  Created by mangdi on 2/1/24.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()  // 불투명으로
//        appearance.configureWithTransparentBackground()  // 투명으로
        appearance.backgroundColor = .systemGray6  // 색상설정

        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Music Search"
    }
    
    private func setupMainTableView() {
//        mainTableView.dataSource = self
//        mainTableView.delegate = self
//        mainTableView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)
    }
}

