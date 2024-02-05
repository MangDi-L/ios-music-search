//
//  MainTableViewCell.swift
//  MusicSearch
//
//  Created by mangdi on 2/5/24.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    private lazy var musicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var musicTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var musicArtistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.alignment = .leading
        [musicTitleLabel, musicArtistNameLabel, musicAlbumNameLabel, musicReleaseDateLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        [musicImageView, labelStackView].forEach { self.addSubview($0) }
        NSLayoutConstraint.activate([
            musicImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            musicImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            musicImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8),
            musicImageView.widthAnchor.constraint(equalTo: musicImageView.heightAnchor, multiplier: 1),
            
            labelStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            labelStackView.leadingAnchor.constraint(equalTo: musicImageView.trailingAnchor, constant: 8),
            labelStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8),
            labelStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8)
        ])
        labelStackView.arrangedSubviews[2].setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}
