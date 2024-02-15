//
//  DetailViewController.swift
//  MusicSearch
//
//  Created by mangdi on 2/6/24.
//

import UIKit

final class DetailViewController: UIViewController {
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
    
    private lazy var favoritePlusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.layer.cornerRadius = UIConstants.moreSingerButtonConerRadius
        button.layer.borderWidth = UIConstants.buttonBorderWidth
        button.layer.borderColor = UIColor(hex: UIColorExtension.moreSingerButtonHex, alpha: UIColorExtension.moreSingerButtonAlpha).cgColor
        button.setImage(UIImage(systemName: SystemImage.heart), for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle(MusicInformation.plusFavorite, for: .normal)
        button.addTarget(self, action: #selector(touchupFavoritePlusButton), for: .touchUpInside)
        return button
    }()
    
    var musicData: Music? {
        didSet {
            setupDetailUI()
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
    
    private func setupDetailUI() {
        guard let musicData,
              let title = musicData.trackName,
              let url = musicData.imageUrl,
              let name = musicData.artistName else { return }
        self.title = title
        musicImageView.setupMusicImageView(urlString: url) { }
        musicTitleLabel.text = title
        musicArtistNameLabel.text = name
        musicAlbumNameLabel.text = musicData.collectionName
        musicReleaseDateLabel.text = musicData.releaseDate?.releaseDateToString
        
        guard var playTime = musicData.playTime,
              musicData.releaseDate != nil,
              musicData.collectionName != nil else {
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
         favoritePlusButton].forEach { view.addSubview($0) }
        
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
            
            favoritePlusButton.topAnchor.constraint(equalTo: moreSingersMusicButotn.bottomAnchor, constant: UIConstants.defaultValue),
            favoritePlusButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.defaultValue),
            favoritePlusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.defaultValue),
            favoritePlusButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: UIConstants.buttonHeightMultiplier)
        ])
    }
    
    @objc private func touchupMoreSingersMusicButotn() {
        DispatchQueue.main.async { [weak self] in
            guard let mainVC = self?.navigationController?.topViewController as? MainViewController else { return }
            mainVC.navigationItem.searchController?.searchBar.text = ""
            mainVC.musicData = []
            mainVC.mainTableView.reloadData()
            mainVC.setupMusicData(search: self?.musicArtistNameLabel.text ?? "")
            mainVC.mainSearchController.searchBar.placeholder = self?.musicArtistNameLabel.text ?? ""
            UIView.animate(withDuration: AnimationTimeConstants.basic) {
                mainVC.mainTableView.setContentOffset(.zero, animated: true)
            }
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func touchupFavoritePlusButton() {
        guard let musicData,
              let image = musicImageView.image,
              let imageData = image.pngData() else { return }
        
        let favoriteMusic = FavoriteMusic(artistName: musicData.artistName,
                                          collectionName: musicData.collectionName,
                                          trackName: musicData.trackName,
                                          imageData: imageData,
                                          playTime: musicData.playTime,
                                          releaseDate: musicData.releaseDate)
        CoreDataManager.shared.insertFavoriteMusic(favoriteMusic: favoriteMusic)
    }
}
