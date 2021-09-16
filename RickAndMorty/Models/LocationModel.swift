//
//  LocationModel.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 17.12.2020.
//

import Foundation

// MARK: - InfoLocationModel
struct InfoLocationModel: Codable {
    let info: InfoModel
    let results: [LocationModel]
}

// MARK: - LocationModel
struct LocationModel: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}

// MARK: - LocationFilter
struct LocationFilter {
    let name: String
    let type: String
    let dimension: String
}
