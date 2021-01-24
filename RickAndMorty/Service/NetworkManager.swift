//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 17.12.2020.
//

import Foundation
import UIKit

enum Method: String {
    case character = "character/"
    case characterPage = "character/?page="
    case location = "location/"
    case locationPage = "location/?page="
    case episode = "episode/"
    case episodePage = "episode/?page="
}

struct NetworkManager {
    
    private let baseURLString = "https://rickandmortyapi.com/api/"
    
    typealias completionHandlerWithData = (Result<Data, Error>) -> Void
    typealias completionHandlerWithDataAndResponse = (Result<(Data, URLResponse), Error>) -> Void
    
    func url(path: String) -> String {
        return baseURLString + path
    }
    
    func performRequest(withURLString urlString: String, completion: @escaping completionHandlerWithData) {
        guard let url = URL(string: urlString) else { return }
        print("HTTPS-Request: \(url)")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                completion(.success(data))
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func performRequestForImage(withURLString urlString: String, completion: @escaping completionHandlerWithDataAndResponse) {
        guard let url = URL(string: urlString) else { return }
        print("Fetch Image \nHTTPS-Request: \(url)")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let data = data, let response = response {
                completion(.success((data, response)))
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func decodeJSONData<T: Codable>(data: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}

struct Client {
    
    init() {}
    
    func character() -> Character {
        let character = Character(client: self)
        return character
    }
    
    func location() -> Location {
        let location = Location(client: self)
        return location
    }
    
    func episode() -> Episode {
        let episode = Episode(client: self)
        return episode
    }
    
    func image() -> Image {
        let image = Image(client: self)
        return image
    }
}
