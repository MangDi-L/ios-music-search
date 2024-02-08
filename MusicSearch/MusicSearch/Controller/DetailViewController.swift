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
        button.tintColor = .systemOrange
        button.layer.cornerRadius = UIConstants.moreSingerButtonConerRadius
        button.backgroundColor = UIColor(hex: UIColorExtension.moreSingerButtonHex, alpha: UIColorExtension.moreSingerButtonAlpha)
        return button
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
        setupMoreSingersMusicButotn()
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupMoreSingersMusicButotn() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .body),
            .foregroundColor: UIColor.black
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
        setupMusicImageView(urlString: url)
        musicTitleLabel.text = title
        musicArtistNameLabel.text = name
        musicAlbumNameLabel.text = musicData.collectionName
        musicReleaseDateLabel.text = musicData.releaseDateToString
        
        guard let playTime = musicData.playTime,
              musicData.releaseDate != nil,
              musicData.collectionName != nil else {
            musicPlayTime.text = MusicInformation.noExist
            musicAlbumNameLabel.text = MusicInformation.noExist
            musicReleaseDateLabel.text = MusicInformation.noExist
            return
        }
        musicPlayTime.text = calculateMusicPlayTime(time: playTime)
    }
    
    private func calculateMusicPlayTime(time: Double) -> String {
        var seconds = round(time / TimeConstants.thousand)
        let minutes = seconds / TimeConstants.sixty
        seconds = Double(Int(seconds) % Int(TimeConstants.sixty))
        if Int(seconds) < Number.ten {
            return "\(Int(minutes)):0\(String(Int(seconds)))"
        } else {
            return "\(Int(minutes)):\(Int(seconds))"
        }
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
         albumNameLabel,
         moreSingersMusicButotn].forEach { view.addSubview($0) }
        
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
            moreSingersMusicButotn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.defaultValue)
        ])
    }
}
