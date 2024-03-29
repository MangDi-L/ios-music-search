//
//  FavoriteDetailViewController.swift
//  MusicSearch
//
//  Created by mangdi on 2/15/24.
//

import UIKit

final class FavoriteDetailViewController: UIViewController {
    private lazy var musicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var musicPlayTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = MusicInformation.title
        return label
    }()
    
    private lazy var musicTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = Number.two
        return label
    }()
    
    private lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = MusicInformation.artist
        return label
    }()
    
    private lazy var musicArtistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = Number.two
        return label
    }()
    
    private lazy var albumNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = MusicInformation.album
        return label
    }()
    
    private lazy var musicAlbumNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = Number.two
        return label
    }()
    
    private lazy var musicReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    private lazy var moreSingersMusicButotn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = UIConstants.moreSingerButtonConerRadius
        button.backgroundColor = UIColor(hex: UIColorExtension.moreSingerButtonHex, alpha: UIColorExtension.moreSingerButtonAlpha)
        button.addTarget(self, action: #selector(touchupMoreSingersMusicButotn), for: .touchUpInside)
        return button
    }()
    
    private lazy var favoriteDeleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.layer.cornerRadius = UIConstants.moreSingerButtonConerRadius
        button.layer.borderWidth = UIConstants.buttonBorderWidth
        button.layer.borderColor = UIColor(hex: UIColorExtension.favoriteDeleteButtonHex, alpha: UIColorExtension.favoriteDeleteButtonAlpha).cgColor
        button.setTitleColor(.systemRed, for: .normal)
        button.setTitle(MusicInformation.deleteFavorite, for: .normal)
        button.addTarget(self, action: #selector(touchupFavoritedDeleteButton), for: .touchUpInside)
        return button
    }()
    
    var favoriteMusicData: FavoriteMusic? {
        didSet {
            setupFavoriteDetailUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tertiarySystemGroupedBackground
        setupAutoLayout()
        setupMoreSingersMusicButotn()
    }
    
    private func setupMoreSingersMusicButotn() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .body)
        ]
        if let artistName = musicArtistNameLabel.text {
            moreSingersMusicButotn.setAttributedTitle(NSAttributedString(string: "\(artistName) \(MusicInformation.moreSinger)", attributes: attributes), for: .normal)
            if artistName == MusicInformation.noExist {
                moreSingersMusicButotn.isEnabled = false
                moreSingersMusicButotn.backgroundColor = .systemGray5
            }
        }
    }
    
    private func setupFavoriteDetailUI() {
        guard let favoriteMusicData,
              let title = favoriteMusicData.trackName,
              let imageData = favoriteMusicData.imageData,
              let name = favoriteMusicData.artistName else { return }
        self.title = title
        musicImageView.image = UIImage(data: imageData)
        musicTitleLabel.text = title
        musicArtistNameLabel.text = name
        musicAlbumNameLabel.text = favoriteMusicData.collectionName
        musicReleaseDateLabel.text = favoriteMusicData.releaseDate?.releaseDateToString
        
        guard var playTime = favoriteMusicData.playTime,
              favoriteMusicData.releaseDate != nil,
              favoriteMusicData.collectionName != nil else {
            musicPlayTime.text = MusicInformation.noExist
            musicAlbumNameLabel.text = MusicInformation.noExist
            musicReleaseDateLabel.text = MusicInformation.noExist
            return
        }
        musicPlayTime.text = playTime.calculateMusicPlayTime()
    }
    
    private func setupAutoLayout() {
        [musicImageView,
         musicTitleLabel,
         musicArtistNameLabel,
         musicAlbumNameLabel,
         musicReleaseDateLabel,
         musicPlayTime,
         titleLabel,
         artistNameLabel,
         albumNameLabel,
         moreSingersMusicButotn,
         favoriteDeleteButton].forEach { view.addSubview($0) }
        
        let musicImageViewHeightEqualWidthConstraint = musicImageView.heightAnchor.constraint(equalTo: musicImageView.widthAnchor, multiplier: UIConstants.defalutMultiplier)
        let musicImageViewHeightLessThanOrEqualToSafeAreaHeight = musicImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: UIConstants.imageViewHeightMultiplier)
        
        musicImageViewHeightLessThanOrEqualToSafeAreaHeight.priority = .defaultHigh
        musicImageViewHeightEqualWidthConstraint.priority = .defaultLow
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        artistNameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        albumNameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            musicImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIConstants.highValue),
            musicImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.defaultValue),
            musicImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.defaultValue),
            musicImageViewHeightEqualWidthConstraint,
            musicImageViewHeightLessThanOrEqualToSafeAreaHeight,
            
            musicPlayTime.topAnchor.constraint(equalTo: musicImageView.bottomAnchor, constant: UIConstants.defaultValue),
            musicPlayTime.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.defaultValue),
            musicPlayTime.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.defaultValue),
            
            titleLabel.topAnchor.constraint(equalTo: musicPlayTime.bottomAnchor, constant: UIConstants.highValue),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.defaultValue),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: UIConstants.labelWidthMulitplier),
            
            musicTitleLabel.topAnchor.constraint(equalTo: musicPlayTime.bottomAnchor, constant: UIConstants.highValue),
            musicTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: UIConstants.defaultValue),
            musicTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.defaultValue),
            
            artistNameLabel.topAnchor.constraint(equalTo: musicTitleLabel.bottomAnchor, constant: UIConstants.defaultValue),
            artistNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.defaultValue),
            artistNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: UIConstants.labelWidthMulitplier),
            
            musicArtistNameLabel.topAnchor.constraint(equalTo: musicTitleLabel.bottomAnchor, constant: UIConstants.defaultValue),
            musicArtistNameLabel.leadingAnchor.constraint(equalTo: artistNameLabel.trailingAnchor, constant: UIConstants.defaultValue),
            musicArtistNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.defaultValue),
            
            albumNameLabel.topAnchor.constraint(equalTo: musicArtistNameLabel.bottomAnchor, constant: UIConstants.defaultValue),
            albumNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.defaultValue),
            albumNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: UIConstants.labelWidthMulitplier),
            
            musicAlbumNameLabel.topAnchor.constraint(equalTo: musicArtistNameLabel.bottomAnchor, constant: UIConstants.defaultValue),
            musicAlbumNameLabel.leadingAnchor.constraint(equalTo: albumNameLabel.trailingAnchor, constant: UIConstants.defaultValue),
            musicAlbumNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.defaultValue),
            
            musicReleaseDateLabel.topAnchor.constraint(equalTo: musicAlbumNameLabel.bottomAnchor, constant: UIConstants.highValue),
            musicReleaseDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.defaultValue),
            musicReleaseDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.defaultValue),
            
            moreSingersMusicButotn.topAnchor.constraint(equalTo: musicReleaseDateLabel.bottomAnchor, constant: UIConstants.highValue),
            moreSingersMusicButotn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.defaultValue),
            moreSingersMusicButotn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.defaultValue),
            moreSingersMusicButotn.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: UIConstants.buttonHeightMultiplier),
            
            favoriteDeleteButton.topAnchor.constraint(equalTo: moreSingersMusicButotn.bottomAnchor, constant: UIConstants.defaultValue),
            favoriteDeleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.defaultValue),
            favoriteDeleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.defaultValue),
            favoriteDeleteButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: UIConstants.buttonHeightMultiplier)
        ])
    }
    
    @objc private func touchupMoreSingersMusicButotn() {
        DispatchQueue.main.async { [weak self] in
            self?.tabBarController?.selectedIndex = .zero
            guard let navigationController = self?.tabBarController?.selectedViewController as? UINavigationController,
                  let mainVC = navigationController.viewControllers[.zero] as? MainViewController else { return }
            
            mainVC.navigationItem.searchController?.searchBar.text = ""
            mainVC.setupMusicData(search: self?.musicArtistNameLabel.text ?? "")
            mainVC.mainSearchController.searchBar.placeholder = self?.musicArtistNameLabel.text ?? ""
            UIView.animate(withDuration: AnimationTimeConstants.basic) {
                mainVC.mainTableView.setContentOffset(.zero, animated: true)
            }
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    @objc private func touchupFavoritedDeleteButton() {
        guard let favoriteMusicData else { return }
        CoreDataManager.shared.deleteFavoriteMusic(favoriteMusic: favoriteMusicData)
        navigationController?.popViewController(animated: true)
    }
}
