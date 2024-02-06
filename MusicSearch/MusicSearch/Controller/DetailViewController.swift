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
        return label
    }()
    
    private lazy var musicReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    var musicData: Music? {
        didSet {
            setupDetailUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAutoLayout()
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupDetailUI() {
        guard let musicData,
              let url = musicData.imageUrl else { return }
        setupMusicImageView(urlString: url)
//        musicPlayTime.text = musicData.playTime
        musicTitleLabel.text = musicData.trackName
        musicArtistNameLabel.text = musicData.artistName
        musicAlbumNameLabel.text = musicData.collectionName
        musicReleaseDateLabel.text = musicData.releaseDateToString
    }
    
    private func setupMusicImageView(urlString: String) {
        guard let url = URL(string: urlString)  else { return }
        
        NetworkManager.shared.fetchImageData(url: urlString) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                let image = UIImage(data: data)
                // 다운로드를 시작한 순간의 url과 이미지가 다운로드 완료된 시점의 url이 동일한지를 확인해주는 코드
                guard urlString == url.absoluteString else { return }
                DispatchQueue.main.async {
                    self.musicImageView.image = image
                }
            case .failure(let failure):
                print("이미지 "+failure.rawValue)
            }
        }
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
         albumNameLabel].forEach { view.addSubview($0) }
        
        let musicImageViewHeightEqualWidthConstraint = musicImageView.heightAnchor.constraint(equalTo: musicImageView.widthAnchor, multiplier: UIConstants.defalutMultiplier)
        let musicImageViewHeightLessThanOrEqualToSafeAreaHeight = musicImageView.heightAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3)
        
        musicImageViewHeightLessThanOrEqualToSafeAreaHeight.priority = .defaultHigh
        musicImageViewHeightEqualWidthConstraint.priority = .defaultLow
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        artistNameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        albumNameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            musicImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIConstants.defaultValue),
            musicImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.defaultValue),
            musicImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.defaultValue),
            musicImageViewHeightEqualWidthConstraint,
            musicImageViewHeightLessThanOrEqualToSafeAreaHeight,
            
            musicPlayTime.topAnchor.constraint(equalTo: musicImageView.bottomAnchor),
            musicPlayTime.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.defaultValue),
            musicPlayTime.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.defaultValue),
            
            titleLabel.topAnchor.constraint(equalTo: musicPlayTime.bottomAnchor, constant: UIConstants.defaultValue),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.defaultValue),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: UIConstants.labelWidthMulitplier),
            
            musicTitleLabel.topAnchor.constraint(equalTo: musicPlayTime.bottomAnchor, constant: UIConstants.defaultValue),
            musicTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: UIConstants.defaultValue),
            musicTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.defaultValue),
            
            artistNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIConstants.defaultValue),
            artistNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.defaultValue),
            artistNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: UIConstants.labelWidthMulitplier),
            
            musicArtistNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIConstants.defaultValue),
            musicArtistNameLabel.leadingAnchor.constraint(equalTo: artistNameLabel.trailingAnchor, constant: UIConstants.defaultValue),
            musicArtistNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.defaultValue),
            
            albumNameLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: UIConstants.defaultValue),
            albumNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.defaultValue),
            albumNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: UIConstants.labelWidthMulitplier),
            
            musicAlbumNameLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: UIConstants.defaultValue),
            musicAlbumNameLabel.leadingAnchor.constraint(equalTo: albumNameLabel.trailingAnchor, constant: UIConstants.defaultValue),
            musicAlbumNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.defaultValue),
            
            musicReleaseDateLabel.topAnchor.constraint(equalTo: musicAlbumNameLabel.bottomAnchor, constant: UIConstants.defaultValue),
            musicReleaseDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.defaultValue),
            musicReleaseDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.defaultValue)
        ])
    }
}
