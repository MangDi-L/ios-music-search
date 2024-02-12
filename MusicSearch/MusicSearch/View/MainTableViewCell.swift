//
//  MainTableViewCell.swift
//  MusicSearch
//
//  Created by mangdi on 2/5/24.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
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
    
    private func stopLoadingIndicator() {
        loadingIndicator.stopAnimating()
    }
    
    private func setupMusicImageView(urlString: String) {
        let fileManager = FileManager()
        let imageCacheKey = NSString(string: urlString)
        guard let url = URL(string: urlString),
              let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory,
                                                             .userDomainMask,
                                                             true).first else { return }
        var filePath = URL(fileURLWithPath: path)
        filePath.appendPathComponent(url.pathComponents[8])
        
        if let imageCacheValue = ImageCacheManager.shared.object(forKey: imageCacheKey) {
            stopLoadingIndicator()
            musicImageView.image = imageCacheValue
        } else if let loadedImageData = try? Data(contentsOf: filePath),
                  let image = UIImage(data: loadedImageData) {
            ImageCacheManager.shared.setObject(image, forKey: imageCacheKey)
            stopLoadingIndicator()
            musicImageView.image = image
        } else {
            NetworkManager.shared.fetchImageData(url: urlString) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let data):
                    guard let image = UIImage(data: data) else { return }
                    // 다운로드를 시작한 순간의 url과 이미지가 다운로드 완료된 시점의 url이 동일한지를 확인해주는 코드
                    guard urlString == url.absoluteString else { return }
                    DispatchQueue.main.async {
                        self.stopLoadingIndicator()
                        self.musicImageView.image = image
                    }
                    ImageCacheManager.shared.setObject(image, forKey: imageCacheKey)
                    fileManager.createFile(atPath: filePath.path,
                                           contents: data,
                                           attributes: nil)
                case .failure(let failure):
                    print("이미지 "+failure.rawValue)
                }
            }
        }
    }
    
    private func setupAutoLayout() {
        [musicImageView, labelStackView].forEach { self.addSubview($0) }
        musicImageView.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            musicImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: UIConstants.defaultValue),
            musicImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIConstants.defaultValue),
            musicImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -UIConstants.defaultValue),
            musicImageView.widthAnchor.constraint(equalTo: musicImageView.heightAnchor, multiplier: UIConstants.defalutMultiplier),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: musicImageView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: musicImageView.centerYAnchor),
            
            labelStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: UIConstants.defaultValue),
            labelStackView.leadingAnchor.constraint(equalTo: musicImageView.trailingAnchor, constant: UIConstants.defaultValue),
            labelStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: UIConstants.defaultValue),
            labelStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -UIConstants.defaultValue)
        ])
        labelStackView.arrangedSubviews[2].setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}
