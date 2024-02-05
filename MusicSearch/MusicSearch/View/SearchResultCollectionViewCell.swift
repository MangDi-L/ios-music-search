//
//  SearchResuldCollectionViewCell.swift
//  MusicSearch
//
//  Created by mangdi on 2/5/24.
//

import UIKit

final class SearchResultCollectionViewCell: UICollectionViewCell {
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
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAutoLayout() {
        [musicImageView, musicTitleLabel].forEach { self.addSubview($0) }
        NSLayoutConstraint.activate([
            musicImageView.topAnchor.constraint(equalTo: self.topAnchor),
            musicImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            musicImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            musicImageView.heightAnchor.constraint(equalTo: musicImageView.widthAnchor, multiplier: UIConstants.defalutMultiplier),
            
            musicTitleLabel.topAnchor.constraint(equalTo: musicImageView.bottomAnchor, constant: UIConstants.defaultValue),
            musicTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            musicTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            musicTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
