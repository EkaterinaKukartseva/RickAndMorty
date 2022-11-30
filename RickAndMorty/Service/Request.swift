//
//  Method.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 17.12.2020.
//

import Foundation
import UIKit
import Alamofire
import OSLog

enum Request {
    
    case character(String)
    case characterPage(String)
    case location(String)
    case locationPage(String)
    case episode(String)
    case episodePage(String)
    
    static let baseURLString = "https://rickandmortyapi.com/api/"
    
    var path: String {
        switch self {
        case .character(let id):
            return "character/\(id)"
        case .characterPage(let page):
            return "character/?page=\(page)"
        case .location(let id):
            return "location/\(id)"
        case .locationPage(let page):
            return "location/?page=\(page)"
        case .episode(let id):
            return "episode/\(id)"
        case .episodePage(let page):
            return "episode/?page=\(page)"
        }
    }
}

// MARK: - URLRequestConvertible
extension Request: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        let url = try (Request.baseURLString + path).asURL()
        os_log(.info, "\(url.absoluteString)")
        return URLRequest(url: url)
    }
}
