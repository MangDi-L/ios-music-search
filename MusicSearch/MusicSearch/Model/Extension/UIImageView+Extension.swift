//
//  UIImageView+Extension.swift
//  MusicSearch
//
//  Created by mangdi on 2/12/24.
//

import UIKit

extension UIImageView {
    func setupMusicImageView(urlString: String, completion: @escaping () -> Void) {
        let fileManager = FileManager()
        let imageCacheKey = NSString(string: urlString)
        guard let url = URL(string: urlString),
              let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory,
                                                             .userDomainMask,
                                                             true).first else { return }
        var filePath = URL(fileURLWithPath: path)
        filePath.appendPathComponent(url.pathComponents[Number.eight])
        
        if let imageCacheValue = ImageCacheManager.shared.object(forKey: imageCacheKey) {
            completion()
            self.image = imageCacheValue
        } else if let loadedImageData = try? Data(contentsOf: filePath),
                  let image = UIImage(data: loadedImageData) {
            ImageCacheManager.shared.setObject(image, forKey: imageCacheKey)
            completion()
            self.image = image
        } else {
            NetworkManager.shared.fetchImageData(url: urlString) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let data):
                    guard let image = UIImage(data: data) else { return }
                    // 다운로드를 시작한 순간의 url과 이미지가 다운로드 완료된 시점의 url이 동일한지를 확인해주는 코드
                    guard urlString == url.absoluteString else { return }
                    DispatchQueue.main.async {
                        completion()
                        self.image = image
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
}
