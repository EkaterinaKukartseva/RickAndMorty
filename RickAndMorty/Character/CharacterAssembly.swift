//
//  CharacterAssembly.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 30.08.2021.
//

import Foundation

protocol CharacterAssemblyProtocol {
    
    func configure(withView: CharacterViewController)
}

class CharacterAssembly: CharacterAssemblyProtocol {
    
    func configure(withView view: CharacterViewController) {
        let presenter = CharacterPresenter(view: view)
        let interactor = CharacterInteractor(presenter: presenter)
        view.presenter = presenter
        presenter.interactor = interactor
    }
}
