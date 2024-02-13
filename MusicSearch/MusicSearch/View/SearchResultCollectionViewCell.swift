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
        self.backgroundColor = .tertiarySystemGroupedBackground
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
        musicImageView.setupMusicImageView(urlString: urlString) { [weak self] in
            self?.stopLoadingIndicator()
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
