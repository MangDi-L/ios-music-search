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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        [musicImageView, 
         musicTitleLabel,
         musicArtistNameLabel,
         musicAlbumNameLabel,
         musicReleaseDateLabel].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            musicImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIConstants.defaultValue),
            musicImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.defaultValue),
            musicImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: UIConstants.defaultValue),
            
            musicTitleLabel.topAnchor.constraint(equalTo: musicImageView.bottomAnchor, constant: UIConstants.defaultValue),
            musicTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.defaultValue),
            musicTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: UIConstants.defaultValue),
            
            musicArtistNameLabel.topAnchor.constraint(equalTo: musicTitleLabel.bottomAnchor, constant: UIConstants.defaultValue),
            musicArtistNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.defaultValue),
            musicArtistNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: UIConstants.defaultValue),
            
            musicAlbumNameLabel.topAnchor.constraint(equalTo: musicArtistNameLabel.bottomAnchor, constant: UIConstants.defaultValue),
            musicAlbumNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.defaultValue),
            musicAlbumNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: UIConstants.defaultValue),
            
            musicReleaseDateLabel.topAnchor.constraint(equalTo: musicAlbumNameLabel.bottomAnchor, constant: UIConstants.defaultValue),
            musicReleaseDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.defaultValue),
            musicReleaseDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: UIConstants.defaultValue)
        ])
    }
}
