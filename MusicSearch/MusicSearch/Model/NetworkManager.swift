//
//  NetworkManager.swift
//  MusicSearch
//
//  Created by mangdi on 2/5/24.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private init() { }
    
    private let session = URLSession(configuration: .default)
    
    // MARK: - GET
    func fetchMusicData(search: String, completion: @escaping ((Result<[Music]?, Error>) -> ())) {
        guard let url = URL(string: "https://itunes.apple.com/search?media=music&term=\(search)") else {
            completion(.failure(<#Error#>))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task: URLSessionDataTask = session.dataTask(with: url) { data, response, error in
            guard (error == nil) else {
                completion(.failure(error!))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...299) ~= response.statusCode else {
                print((response as? HTTPURLResponse)?.statusCode as Any)
                completion(.failure(error!))
                return
            }
            
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(SearchMusicInformation.self, from: data)
                completion(.success(decodedData.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
