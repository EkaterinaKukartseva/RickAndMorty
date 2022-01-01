//
//  CharacterDetailsRouter.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 31.08.2021.
//

import Foundation

protocol CharacterDetailsRouterProtocol {
    
    /// Инициализация роутера модуля `CharacterDetails`
    /// - Parameters:
    ///   - viewController: `CharacterDetailsViewController`
    init(viewController: CharacterDetailsViewController)
    
    /// Открыть экран со списком серий
    /// - Parameter ids: ids серий
    func openEpisodeListModule(with ids: [Int])
    
    /// Открыть экран с информацией о местонахождении персонажа
    /// - Parameter url: url локации
    func openLocationDetailsModule(with url: String)
    
    /// Открыть экран с информацией о месте происхождения персонажа
    /// - Parameter url: url локации
    func openOriginDetailsModule(with url: String)
}

class CharacterDetailsRouter: CharacterDetailsRouterProtocol {

    private let viewController: CharacterDetailsViewController?
    
    required init(viewController: CharacterDetailsViewController) {
        self.viewController = viewController
    }
    
    func openEpisodeListModule(with ids: [Int]) {
        viewController?.performSegue(withIdentifier: "showEpisodeList", sender: ids)
    }
    
    func openLocationDetailsModule(with url: String) {
        viewController?.performSegue(withIdentifier: "showLocation", sender: url)
    }
    
    func openOriginDetailsModule(with url: String) {
        viewController?.performSegue(withIdentifier: "showLocation", sender: url)
    }
}
