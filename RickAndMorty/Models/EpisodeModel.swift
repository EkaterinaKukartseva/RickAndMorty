//
//  EpisodeModel.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 17.12.2020.
//

import Foundation

// MARK: - InfoEpisodeModel
struct InfoEpisodeModel: Codable {
    let info: Info
    let results: [EpisodeModel]
}

// MARK: - EpisodeModel
struct EpisodeModel: Codable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name, episode, characters, url, created
        case airDate = "air_date"
    }
}
