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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAutoLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        musicImageView.image = nil
        musicTitleLabel.text = nil
        musicArtistNameLabel.text = nil
        musicAlbumNameLabel.text = nil
        musicReleaseDateLabel.text = nil
    }
    
    func setupCellData(data: Music) {
        guard let imageUrl = data.imageUrl else { return }
        setupMusicImageView(urlString: imageUrl)
        musicTitleLabel.text = data.trackName
        musicArtistNameLabel.text = data.artistName
        musicAlbumNameLabel.text = data.collectionName
        musicReleaseDateLabel.text = data.releaseDateToString
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
        [musicImageView, labelStackView].forEach { self.addSubview($0) }
        NSLayoutConstraint.activate([
            musicImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: UIConstants.defaultValue),
            musicImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIConstants.defaultValue),
            musicImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -UIConstants.defaultValue),
            musicImageView.widthAnchor.constraint(equalTo: musicImageView.heightAnchor, multiplier: 1),
            
            labelStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: UIConstants.defaultValue),
            labelStackView.leadingAnchor.constraint(equalTo: musicImageView.trailingAnchor, constant: UIConstants.defaultValue),
            labelStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: UIConstants.defaultValue),
            labelStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -UIConstants.defaultValue)
        ])
        labelStackView.arrangedSubviews[2].setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}
