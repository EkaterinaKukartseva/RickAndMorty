//
//  CharacterDetailsRouter.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 31.08.2021.
//

import Foundation

protocol CharacterDetailsRouterProtocol {
    
    init(viewController: CharacterDetailsViewController)
    
    func openEpisodeList(with ids: [Int])
    
    func openLocation(with url: String)
    
    func openOrigin(with url: String)
}

class CharacterDetailsRouter: CharacterDetailsRouterProtocol {

    private let viewController: CharacterDetailsViewController?
    
    required init(viewController: CharacterDetailsViewController) {
        self.viewController = viewController
    }
    
    func openEpisodeList(with ids: [Int]) {
        viewController?.performSegue(withIdentifier: "showEpisodeList", sender: ids)
    }
    
    func openLocation(with url: String) {
        viewController?.performSegue(withIdentifier: "showLocation", sender: url)
    }
    
    func openOrigin(with url: String) {
        viewController?.performSegue(withIdentifier: "showLocation", sender: url)
    }
}
