//
//  CoreDataManager.swift
//  MusicSearch
//
//  Created by mangdi on 2/13/24.
//

import UIKit
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    private init() { }
    
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    private lazy var context = appDelegate?.persistentContainer.viewContext
    
    // MARK: - [Read] 코어데이터에 저장된 데이터 모두 읽어오기
    private func fetchFavoriteMusicEntities2() -> [FavoriteMusicEntity] {
        var favoriteMusicEntities: [FavoriteMusicEntity] = []
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: "FavoriteMusicEntity")
            let dateOrder = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [dateOrder]
            do {
                if let fetchedFavoriteMusicEntities = try context.fetch(request) as? [FavoriteMusicEntity] {
                    favoriteMusicEntities = fetchedFavoriteMusicEntities
                }
            } catch {
                print("가져오는 것 실패")
            }
        }
        
        return favoriteMusicEntities
    }
    
    private func fetchFavoriteMusicEntities() -> [FavoriteMusicEntity] {
        do {
            let request = FavoriteMusicEntity.fetchRequest()
            guard let context else { return [] }
            return try context.fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func fetchFavoriteMusics() -> [FavoriteMusic] {
        let favoriteMusicEntities = fetchFavoriteMusicEntities()
        let favoriteMusics = favoriteMusicEntities.map {
            FavoriteMusic(id: $0.id,
                          artistName: $0.artistName,
                          collectionName: $0.collectionName,
                          trackName: $0.trackName,
                          imageData: $0.imageData,
                          playTime: $0.playTime,
                          releaseDate: $0.releaseDate)
        }
        return favoriteMusics
    }
    
    func insertFavoriteMusic(favoriteMusic: FavoriteMusic) {
        guard let context else { return }
        let favoriteMusicEntity = FavoriteMusicEntity(context: context)
        favoriteMusicEntity.id = favoriteMusic.id
        favoriteMusicEntity.artistName = favoriteMusic.artistName
        favoriteMusicEntity.collectionName = favoriteMusic.collectionName
        favoriteMusicEntity.imageData = favoriteMusic.imageData
        favoriteMusicEntity.playTime = favoriteMusic.playTime ?? .zero
        favoriteMusicEntity.releaseDate = favoriteMusic.releaseDate
        favoriteMusicEntity.trackName = favoriteMusic.trackName
        appDelegate?.saveContext()
    }
    
    func deleteFavoriteMusic(favoriteMusic: FavoriteMusic) {
        guard let context else { return }
        let favoriteMusicEntities = fetchFavoriteMusicEntities()
        guard let favoriteMusicEntity = favoriteMusicEntities.first(where: { $0.id == favoriteMusic.id }) else { return }
        context.delete(favoriteMusicEntity)
        appDelegate?.saveContext()
    }
}
