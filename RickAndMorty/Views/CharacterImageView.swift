//
//  CharacterUIImageView.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 24.01.2021.
//

import UIKit

class CharacterImageView: UIImageView {
    
    func fetchImage(from url: String) {
        guard let imageURL = URL(string: url) else {
            image = UIImage(named: "RickAndMorty")
            return
        }
        
        // Загрузка изображения из кэша
        if let cachedImage = getCahedImage(from: imageURL) {
            image = cachedImage
            return
        }
        
        // Загрузка изображения из сети
        client.image().fetchImage(byURL: url) { (result) in
            switch result {
            case .success((let data, let response)):
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
                
                self.saveDataToCache(with: data, and: response)
            case .failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
        
    }
    
    private func getCahedImage(from url:URL) -> UIImage? {
        let urlRequest = URLRequest(url: url)
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse){
        guard let url = response.url else { return }
        let urlRequest = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
        
    }
    
}
