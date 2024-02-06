//
//  MusicModel.swift
//  MusicSearch
//
//  Created by mangdi on 2/5/24.
//

import Foundation

// MARK: - SearchMusicInformation
struct SearchMusicInformation: Codable {
    let resultCount: Int?
    let results: [Music]?
}

// MARK: - Music
struct Music: Codable {
    let artistName: String?
    let collectionName, trackName: String?
    let imageUrl: String?
    let playTime: Double?
    private let releaseDate: String?
    
    // 2023-04-07T12:00:00Z
    // 2015-10-23T07:00:00Z
    // 2014-05-16T07:00:00Z
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

    enum CodingKeys: String, CodingKey {
        case artistName, collectionName, trackName
        case imageUrl = "artworkUrl100"
        case playTime = "trackTimeMillis"
        case releaseDate
    }
}
