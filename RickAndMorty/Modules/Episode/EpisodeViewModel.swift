//
//  EpisodeViewModel.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 22.07.2021.
//

import Foundation

// MARK: EpisodeViewModelProtocol
protocol EpisodeViewModelProtocol {
    
    /// Название эпизода
    var episodeName: String { get }
    
    /// Дата выпуска эпизода
    var airDate: String { get }
    
    /// Номер эпизода
    var episodeNumber: String { get }
    
    /// Инициализатор
    /// - Parameter episode: EpisodeModel
    init(episode: EpisodeModel)
}

// MARK: EpisodeViewModel
class EpisodeViewModel: EpisodeViewModelProtocol {
    
    var episodeName: String { episode.name }
    
    var airDate: String { episode.airDate }
    
    var episodeNumber: String { episode.episode }
    
    private let episode: EpisodeModel
    
    required init(episode: EpisodeModel) {
        self.episode = episode
    }
}
