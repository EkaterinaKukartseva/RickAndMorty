//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 17.12.2020.
//

import Foundation

// MARK: - InfoCharacterModel
struct InfoCharacterModel: Codable {
    let info: Info
    let results: [CharacterModel]
}

// MARK: - Info
struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

// MARK: - CharacterModel
struct CharacterModel: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: CharacterOriginModel
    let location: CharacterLocationModel
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - CharacterOriginModel
public struct CharacterOriginModel: Codable {
    public let name: String
    public let url: String
}

// MARK: - CharacterLocationModel
public struct CharacterLocationModel: Codable {
    public let name: String
    public let url: String
}
