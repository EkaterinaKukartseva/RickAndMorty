//
//  ImageService.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 24.01.2021.
//

import Foundation
import Alamofire

struct ImageService {

    func fetchImage(byURL url: String, completion: @escaping (Result<(Data, URLResponse), Error>) -> Void) {
        AF.download(url).validate().responseData { response in
            switch response.result {
            case .success(let data):
                completion(.success((data, response.response!)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
