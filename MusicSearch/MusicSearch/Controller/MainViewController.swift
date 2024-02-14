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
    
    static var isActivateLatestButton: Bool = true
    private let searchResultVC = SearchResultViewController()
    var mainSearchController: UISearchController = UISearchController()
    var musicData: [Music] = []
    var mainTableViewBottomConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGroupedBackground
        setupNavigationBar()
        setupSearchBar()
        setupLatelySearching()
        setupMainTableView()
        setupAutoLayout()
        setupKeyboardNotification()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        navigationItem.searchController?.searchBar.endEditing(true)
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
        navigationController?.navigationBar.prefersLargeTitles = true
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
            .font: UIFont.preferredFont(forTextStyle: .callout),
            .foregroundColor: UIColor.systemBrown
        ]
        button.setAttributedTitle(NSAttributedString(string: NavigationBarText.rightBarButtonTitle, attributes: attributes), for: .normal)
        button.tintColor = .systemOrange
        button.frame = CGRect(x: .zero, y: .zero, width: systemImage.size.width, height: systemImage.size.height)
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
    
    private func setupLatelySearching() {
        guard let text = UserDefaults.standard.string(forKey: Keys.searchbarTextKey) else {
            setupMusicData(search: "")
            return
        }
        setupMusicData(search: text)
        mainSearchController.searchBar.placeholder = text
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
    
    private func setupKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardMoveUpAction), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardMoveDownAction), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupAutoLayout() {
        view.addSubview(mainTableView)
        
        mainTableViewBottomConstraint = mainTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        mainTableViewBottomConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
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
        DispatchQueue.main.async { [weak self] in
            self?.searchResultVC.searchResultCollectionView.reloadData()
        }
    }
    
    @objc private func keyboardMoveUpAction(notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            mainTableViewBottomConstraint?.constant = -keyboardHeight
            UIView.animate(withDuration: AnimationTimeConstants.basic) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardMoveDownAction(notification: Notification) {
        mainTableViewBottomConstraint?.constant = .zero
        UIView.animate(withDuration: AnimationTimeConstants.basic) {
            self.view.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
        let height = view.frame.height / Cell.tableCellHeightDevidingValue
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
        UserDefaults.standard.setValue(searchController.searchBar.text, forKey: Keys.searchbarTextKey)
    }
}
