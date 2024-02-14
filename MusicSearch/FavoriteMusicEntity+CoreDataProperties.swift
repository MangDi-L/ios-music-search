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
}

extension FavoriteMusicEntity: Identifiable {

}
