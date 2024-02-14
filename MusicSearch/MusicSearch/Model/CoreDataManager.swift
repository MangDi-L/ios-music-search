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
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    // MARK: - [Read] 코어데이터에 저장된 데이터 모두 읽어오기
    private func fetchFavoriteMusicEntities() -> [FavoriteMusicEntity] {
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
    
    private func fetchFavoriteMusicEntities2() -> [FavoriteMusicEntity] {
        do {
            let request = FavoriteMusicEntity.fetchRequest()
            guard let context else { return [] }
            return try context.fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
