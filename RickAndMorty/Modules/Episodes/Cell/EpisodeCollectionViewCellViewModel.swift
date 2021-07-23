//
//  EpisodeCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 23.07.2021.
//

import Foundation

// MARK: EpisodeCollectionViewCellViewModelProtocol
protocol EpisodeCollectionViewCellViewModelProtocol {
    
    /// Номер серии
    var episodeName: String { get }
    
    /// Инициализатор
    /// - Parameter episode: EpisodeModel
    init(episode: EpisodeModel)
}

// MARK: EpisodeCollectionViewCellViewModel
class EpisodeCollectionViewCellViewModel: EpisodeCollectionViewCellViewModelProtocol {
    
    var episodeName: String { episode.episode }
    private let episode: EpisodeModel
    
    required init(episode: EpisodeModel) {
        self.episode = episode
    }
}
