//
//  FavoriteMusic.swift
//  MusicSearch
//
//  Created by mangdi on 2/14/24.
//

import Foundation

struct FavoriteMusic: Identifiable {
    let id: UUID?
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let imageData: Data?
    let playTime: Double?
    let releaseDate: String?
    
    init(id: UUID? = UUID(),
         artistName: String?,
         collectionName: String?,
         trackName: String?,
         imageData: Data?,
         playTime: Double?,
         releaseDate: String?) {
        self.id = id
        self.artistName = artistName
        self.collectionName = collectionName
        self.trackName = trackName
        self.imageData = imageData
        self.playTime = playTime
        self.releaseDate = releaseDate
    }
}
