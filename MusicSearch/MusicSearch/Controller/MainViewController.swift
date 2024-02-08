//
//  ViewController.swift
//  MusicSearch
//
//  Created by mangdi on 2/1/24.
//

import UIKit

final class MainViewController: UIViewController {
    let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let item = setupRightBarButtonItem(isActivation: MainViewController.isActivateLatestButton)
        return item
    }()
    
    private let searchResultVC = SearchResultViewController()
    var mainSearchController: UISearchController = UISearchController()
    var musicData: [Music] = []
    static var isActivateLatestButton: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupNavigationBar()
        setupSearchBar()
        setupMainTableView()
        setupAutoLayout()
        setupMusicData(search: "uu")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
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
        title = NavigationBarText.title
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func setupRightBarButtonItem(isActivation: Bool) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        let systemImage: UIImage
        if isActivation {
            guard let image = UIImage(systemName: SystemImage.arrowDown) else { return UIBarButtonItem() }
            systemImage = image
        } else {
            guard let image = UIImage(systemName: SystemImage.arrowUp) else { return UIBarButtonItem() }
            systemImage = image
        }
        
        button.setImage(systemImage, for: .normal)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .caption1),
            .foregroundColor: UIColor.black
        ]
        button.setAttributedTitle(NSAttributedString(string: NavigationBarText.rightBarButtonTitle, attributes: attributes), for: .normal)
        button.tintColor = .systemOrange
        button.frame = CGRect(x: 0, y: 0, width: systemImage.size.width, height: systemImage.size.height)
        button.addTarget(self, action: #selector(touchupRightBarButtonItem), for: .touchUpInside)
        
        return UIBarButtonItem(customView: button)
    }
    
    private func setupSearchBar() {
        mainSearchController = UISearchController(searchResultsController: self.searchResultVC)
        mainSearchController.searchBar.placeholder = NavigationBarText.searchBarPlaceHolder
        mainSearchController.searchBar.searchBarStyle = .default
        mainSearchController.searchBar.autocapitalizationType = .none
        mainSearchController.hidesNavigationBarDuringPresentation = false
        mainSearchController.searchResultsUpdater = self
        mainSearchController.searchBar.autocorrectionType = .no
        mainSearchController.searchBar.spellCheckingType = .no
        navigationItem.searchController = mainSearchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupMainTableView() {
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.register(MainTableViewCell.self, forCellReuseIdentifier: Cell.mainTableViewCellIdentifier)
    }
    
    func setupMusicData(search: String) {
        NetworkManager.shared.fetchMusicData(search: search) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                guard let data else { return }
                self.musicData = sortingMusicLatestDate(musics: data, isLatest: MainViewController.isActivateLatestButton)
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("메인 ", error.rawValue)
                }
            }
        }
    }
    
    func sortingMusicLatestDate(musics: [Music], isLatest: Bool) -> [Music] {
        if isLatest {
            let sortedMusics = musics.sorted { return $0.releaseDate ?? "" > $1.releaseDate ?? "" }
            return sortedMusics
        } else {
            let sortedMusics = musics.sorted { return $0.releaseDate ?? "" < $1.releaseDate ?? "" }
            return sortedMusics
        }
    }
    
    private func setupAutoLayout() {
        view.addSubview(mainTableView)
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func touchupRightBarButtonItem() {
        MainViewController.isActivateLatestButton.toggle()
        navigationItem.rightBarButtonItem = setupRightBarButtonItem(isActivation: MainViewController.isActivateLatestButton)
        self.musicData = sortingMusicLatestDate(musics: self.musicData, isLatest: MainViewController.isActivateLatestButton)
        DispatchQueue.main.async { [weak self] in
            self?.mainTableView.reloadData()
        }
        
        let musicData = searchResultVC.musicData
        let sortedMusicData = sortingMusicLatestDate(musics: musicData, isLatest: MainViewController.isActivateLatestButton)
        searchResultVC.musicData = sortedMusicData
        DispatchQueue.main.async {
            self.searchResultVC.searchResultCollectionView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.mainTableViewCellIdentifier, for: indexPath) as? MainTableViewCell ?? MainTableViewCell()
        cell.setupCellData(data: musicData[indexPath.row])
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = view.safeAreaLayoutGuide.layoutFrame.height / Cell.cellHeightDevidingValue
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.musicData = musicData[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchResultVC = searchController.searchResultsController as? SearchResultViewController ?? SearchResultViewController()
        searchResultVC.setupMusicData(search: searchController.searchBar.text ?? "")
    }
}
