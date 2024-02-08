//
//  SearchResuldCollectionViewCell.swift
//  MusicSearch
//
//  Created by mangdi on 2/5/24.
//

import UIKit

final class SearchResultCollectionViewCell: UICollectionViewCell {
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.style = .medium
        indicator.startAnimating()
        return indicator
    }()
    
    private lazy var musicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var musicTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var musicArtistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption2)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        loadingIndicator.startAnimating()
        musicImageView.image = nil
        musicTitleLabel.text = nil
        musicArtistNameLabel.text = nil
    }
    
    func setupCellData(data: Music) {
        guard let imageUrl = data.imageUrl else { return }
        setupMusicImageView(urlString: imageUrl)
        musicTitleLabel.text = data.trackName
        musicArtistNameLabel.text = data.artistName
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
                    self.stopLoadingIndicator()
                    self.musicImageView.image = image
                }
            case .failure(let failure):
                print("이미지 "+failure.rawValue)
            }
        }
    }
    
    private func stopLoadingIndicator() {
        loadingIndicator.stopAnimating()
    }
    
    private func setupAutoLayout() {
        [musicImageView, musicTitleLabel, musicArtistNameLabel].forEach { self.addSubview($0) }
        musicImageView.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            musicImageView.topAnchor.constraint(equalTo: self.topAnchor),
            musicImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            musicImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            musicImageView.heightAnchor.constraint(equalTo: musicImageView.widthAnchor, multiplier: UIConstants.defalutMultiplier),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: musicImageView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: musicImageView.centerYAnchor),
            
            musicTitleLabel.topAnchor.constraint(equalTo: musicImageView.bottomAnchor, constant: UIConstants.defaultValue),
            musicTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            musicTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            musicArtistNameLabel.topAnchor.constraint(equalTo: musicTitleLabel.bottomAnchor),
            musicArtistNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            musicArtistNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
