//
//  HomeRouter.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 14/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - HomeRouterProtocol
protocol HomeRouterProtocol {
    
    init(viewController: HomeViewController)
}

// MARK: - HomeRouter + HomeRouterProtocol
final class HomeRouter: HomeRouterProtocol {
    
    private let viewController: HomeViewController?
    
    required init(viewController: HomeViewController) {
        self.viewController = viewController
    }
}
