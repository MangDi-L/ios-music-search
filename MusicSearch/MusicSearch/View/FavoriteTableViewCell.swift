//
//  FavoriteTableViewCell.swift
//  MusicSearch
//
//  Created by mangdi on 2/14/24.
//

import UIKit

final class FavoriteTableViewCell: UITableViewCell {
    private lazy var musicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var musicTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private lazy var musicArtistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    private lazy var musicAlbumNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var musicReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = UIConstants.defaultValue
        stackView.alignment = .leading
        [musicTitleLabel, musicArtistNameLabel, musicAlbumNameLabel, musicReleaseDateLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .tertiarySystemGroupedBackground
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        musicImageView.image = nil
        musicTitleLabel.text = nil
        musicArtistNameLabel.text = nil
        musicAlbumNameLabel.text = nil
        musicReleaseDateLabel.text = nil
    }
    
    func setupCellData(data: FavoriteMusic) {
        guard let imageData = data.imageData,
              let image = UIImage(data: imageData) else { return }
        musicImageView.image = image
        musicTitleLabel.text = data.trackName
        musicArtistNameLabel.text = data.artistName
        musicAlbumNameLabel.text = data.collectionName
        musicReleaseDateLabel.text = data.releaseDateToString
    }
    
    private func setupAutoLayout() {
        [musicImageView, labelStackView].forEach { self.addSubview($0) }
        
        NSLayoutConstraint.activate([
            musicImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: UIConstants.defaultValue),
            musicImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIConstants.defaultValue),
            musicImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -UIConstants.defaultValue),
            musicImageView.widthAnchor.constraint(equalTo: musicImageView.heightAnchor, multiplier: UIConstants.defalutMultiplier),
            
            labelStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: UIConstants.defaultValue),
            labelStackView.leadingAnchor.constraint(equalTo: musicImageView.trailingAnchor, constant: UIConstants.defaultValue),
            labelStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: UIConstants.defaultValue),
            labelStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -UIConstants.defaultValue)
        ])
        labelStackView.arrangedSubviews[2].setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}
