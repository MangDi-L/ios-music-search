//
//  FavoriteMusicEntity+CoreDataProperties.swift
//  MusicSearch
//
//  Created by mangdi on 2/13/24.
//
//

import Foundation
import CoreData


extension FavoriteMusicEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMusicEntity> {
        return NSFetchRequest<FavoriteMusicEntity>(entityName: "FavoriteMusicEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var artistName: String?
    @NSManaged public var collectionName: String?
    @NSManaged public var trackName: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var playTime: Double
    @NSManaged public var releaseDate: String?
    
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

extension FavoriteMusicEntity : Identifiable {

}
