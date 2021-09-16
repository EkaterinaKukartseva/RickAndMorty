//
//  HomePresenter.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 14/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - HomePresenter
final class HomePresenter: HomeViewOutputProtocol {

    private let view: HomeViewInputProtocol?
    var interactor: HomeInteractorInputProtocol!
    var router: HomeRouterProtocol!
    
    required init(view: HomeViewInputProtocol) {
        self.view = view
    }
}

// MARK: - HomePresenter + HomeInteractorOutputProtocol
extension HomePresenter: HomeInteractorOutputProtocol {}
