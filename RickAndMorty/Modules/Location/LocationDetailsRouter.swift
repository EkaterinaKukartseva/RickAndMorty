//
//  LocationDetailsRouter.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 31.08.2021.
//

import Foundation

protocol LocationDetailsRouterProtocol {
    
    init(viewController: LocationDetailsViewController)
    
    func openCharacterList(with urls: [String])
}

class LocationDetailsRouter: LocationDetailsRouterProtocol {

    unowned let viewController: LocationDetailsViewController
    
    required init(viewController: LocationDetailsViewController) {
        self.viewController = viewController
    }
    
    func openCharacterList(with urls: [String]) {
        viewController.performSegue(withIdentifier: "showCharacterList", sender: urls)
    }
}
