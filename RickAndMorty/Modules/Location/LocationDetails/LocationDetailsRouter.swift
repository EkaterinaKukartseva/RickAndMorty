//
//  LocationDetailsRouter.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 31.08.2021.
//

import Foundation

protocol LocationDetailsRouterProtocol {
    
    init(viewController: LocationDetailsViewController)
    
    /// Открыть экран со списком персонажей
    /// - Parameter ids: ids персонажей
    func openCharacterListModule(with ids: [Int])
}

class LocationDetailsRouter: LocationDetailsRouterProtocol {

    private let viewController: LocationDetailsViewController?
    
    required init(viewController: LocationDetailsViewController) {
        self.viewController = viewController
    }
    
    func openCharacterListModule(with ids: [Int]) {
        viewController?.performSegue(withIdentifier: "showCharacterList", sender: ids)
    }
}
