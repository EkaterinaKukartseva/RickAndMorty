//
//  CharacterDetailsRouter.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 31.08.2021.
//

import Foundation

protocol CharacterDetailsRouterProtocol {
    
    init(viewController: CharacterDetailsViewController)
    
    func openEpisodeList(with list: [String])
    
    func openLocation(with model: CharacterLocationModel)
    
    func openOrigin(with model: CharacterOriginModel)
}

class CharacterDetailsRouter: CharacterDetailsRouterProtocol {

    unowned let viewController: CharacterDetailsViewController
    
    required init(viewController: CharacterDetailsViewController) {
        self.viewController = viewController
    }
    
    func openEpisodeList(with list: [String]) {
        viewController.performSegue(withIdentifier: "showEpisodeList", sender: list)
    }
    
    func openLocation(with model: CharacterLocationModel) {
        viewController.performSegue(withIdentifier: "showLocation", sender: model)
    }
    
    func openOrigin(with model: CharacterOriginModel) {
        viewController.performSegue(withIdentifier: "showLocation", sender: model)
    }
}
