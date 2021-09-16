//
//  HomeInteractor.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 14/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - HomeInteractorInputProtocol
protocol HomeInteractorInputProtocol: AnyObject {

    init(presenter: HomeInteractorOutputProtocol)
}

// MARK: - HomeInteractorOutputProtocol
protocol HomeInteractorOutputProtocol {}

// MARK: - HomeInteractor
final class HomeInteractor: HomeInteractorInputProtocol {

    var presenter: HomeInteractorOutputProtocol?

    required init(presenter: HomeInteractorOutputProtocol) {
        self.presenter = presenter
    }
}
