//
//  LocationListRouter.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 16/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - LocationListRouterProtocol
protocol LocationListRouterProtocol {
    
    init(viewController: LocationListViewController)
}

// MARK: - LocationListRouter + LocationListRouterProtocol
final class LocationListRouter: LocationListRouterProtocol {
    
    private let viewController: LocationListViewController?
    
    required init(viewController: LocationListViewController) {
        self.viewController = viewController
    }
}
