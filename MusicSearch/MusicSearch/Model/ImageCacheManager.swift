//
//  ImageCacheManager.swift
//  MusicSearch
//
//  Created by mangdi on 2/12/24.
//

import UIKit

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() { }
}
