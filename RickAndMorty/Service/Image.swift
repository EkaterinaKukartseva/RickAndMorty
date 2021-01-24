//
//  Image.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 24.01.2021.
//

import Foundation

struct Image {
    
    public init(client: Client) {
        self.client = client
    }
    
    let networkManager: NetworkManager = NetworkManager()
    let client: Client
    
    func fetchImage(byURL url: String, completion: @escaping (Result<(Data, URLResponse), Error>) -> Void) {
        networkManager.performRequestForImage(withURLString: url) { result in
            switch result {
            case .success((let data, let response)):
                completion(.success((data, response)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
