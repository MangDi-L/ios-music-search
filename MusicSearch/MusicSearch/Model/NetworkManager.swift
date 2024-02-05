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
    var imageTask: URLSessionDataTask?
    
    // MARK: - GET
    func fetchMusicData(search: String, completion: @escaping ((Result<[Music]?, NetworkError>) -> ())) {
        guard let url = URL(string: "https://itunes.apple.com/search?media=music&term=\(search)") else {
            completion(.failure(.urlConvertError))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task: URLSessionDataTask = session.dataTask(with: url) { data, response, error in
            guard (error == nil) else {
                completion(.failure(.networkError))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...299) ~= response.statusCode else {
                print((response as? HTTPURLResponse)?.statusCode as Any)
                completion(.failure(.responseError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.dataNilError))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(SearchMusicInformation.self, from: data)
                completion(.success(decodedData.results))
            } catch {
                completion(.failure(.decodeError))
            }
        }
        task.resume()
    }
    
    // MARK: - Image GET
    func fetchImageData(url: String, completion: @escaping (Result<Data, NetworkError>) -> ()) {
        guard let url = URL(string: url) else {
            completion(.failure(.urlConvertError))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        imageTask = URLSession(configuration: .default).dataTask(with: request, completionHandler: { data, response, error in
            guard (error == nil) else {
                completion(.failure(.networkError))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...299) ~= response.statusCode else {
                completion(.failure(.responseError))
                return
            }
            
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(.dataNilError))
            }
        })
        imageTask?.resume()
    }
}
