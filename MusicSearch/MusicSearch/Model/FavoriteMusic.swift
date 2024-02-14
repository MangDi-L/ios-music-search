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
    let imageUrl: String?
    let playTime: Double?
    let releaseDate: String?
    
    var releaseDateToString: String {
        guard let releaseDate,
              let isoDate = ISO8601DateFormatter().date(from: releaseDate) else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: isoDate)
        return date
    }
}
