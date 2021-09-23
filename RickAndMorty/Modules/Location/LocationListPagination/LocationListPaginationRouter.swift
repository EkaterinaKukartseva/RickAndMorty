//
//  LocationListPaginationRouter.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 16/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - LocationListPaginationRouterProtocol
protocol LocationListPaginationRouterProtocol {
    
    init(viewController: LocationListPaginationViewController)
    
    /// Открыть модуль с детальной информацией о локации
    /// - Parameter url: url локации
    func openLocationDetailsModule(with url: String)
}

// MARK: - LocationListPaginationRouter + LocationListPaginationRouterProtocol
final class LocationListPaginationRouter: LocationListPaginationRouterProtocol {
    
    private let viewController: LocationListPaginationViewController?
    
    required init(viewController: LocationListPaginationViewController) {
        self.viewController = viewController
    }
    
    func openLocationDetailsModule(with url: String) {
        viewController?.performSegue(withIdentifier: "showLocation", sender: url)
    }
}
