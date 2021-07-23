//
//  EpisodesViewModel.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 22.07.2021.
//

import Foundation

// MARK: EpisodesViewModelProtocol
protocol EpisodesViewModelProtocol {
    
    /// Список эпизодов
    var episodes: [EpisodeModel] { get }
    
    /// Получить один эпизод
    /// - Parameters:
    ///   - id: идентификатор
    ///   - completion: completion
    func fetchEpisode(by id: Int, completion: @escaping() -> Void)
    
    /// Получить список эпизодов
    /// - Parameters:
    ///   - id: идентификаторы
    ///   - completion: completion
    func fetchEpisodes(by ids: [Int], completion: @escaping() -> Void)
    
    /// Вернуть количество ячеек
    /// - Returns: Количество ячеек
    func numberOfRows() -> Int
    
    /// Получить ViewModel ячейки
    /// - Parameter indexPath: IndexPath
    func cellViewModel(at indexPath: IndexPath) -> EpisodeCollectionViewCellViewModelProtocol?
    
    /// Получить эпизод
    /// - Parameter indexPath: IndexPath
    func episode(at indexPath: IndexPath) -> EpisodeModel
}

// MARK: EpisodesViewModel
class EpisodesViewModel: EpisodesViewModelProtocol {

    var episodes: [EpisodeModel] = []
    
    func numberOfRows() -> Int {
        episodes.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> EpisodeCollectionViewCellViewModelProtocol? {
        EpisodeCollectionViewCellViewModel(episode: episodes[indexPath.row])
    }
    
    func episode(at indexPath: IndexPath) -> EpisodeModel {
        episodes[indexPath.row]
    }
    
    func fetchEpisode(by id: Int, completion: @escaping () -> Void) {
        client.episode().fetchEpisode(byID: id) { (result) in
            switch result {
            case .success(let model):
                self.episodes = [model]
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
        return
    }
    
    func fetchEpisodes(by ids: [Int], completion: @escaping () -> Void) {
        client.episode().fetchEpisodes(byID: ids) { (result) in
            switch result {
            case .success(let model):
                self.episodes = model
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
}
