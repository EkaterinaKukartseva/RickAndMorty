//
//  CharacterPresenter.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 30.08.2021.
//

import Foundation

// MARK: - CharacterDetails
struct CharacterDetails {
    
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let episode: [String]
    let origin: CharacterOriginModel
    let location: CharacterLocationModel
    let image: String
}

// MARK: - CharacterDetailsPresenter
class CharacterDetailsPresenter: CharacterDetailsViewOutputProtocol {

    unowned let view: CharacterDetailsViewInputProtocol
    var interactor: CharacterDetailsInteractorInputProtocol!
    var router: CharacterDetailsRouterProtocol!
    
    private var character: CharacterDetails!
    
    required init(view: CharacterDetailsViewInputProtocol) {
        self.view = view
    }
    
    func didTabShowCharacter(with id: Int) {
        interactor.provideCharacter(with: id)
    }
    
    func showEpisodeList() {
        router.openEpisodeList(with: character.episode)
    }
    
    func showLocation() {
        router.openLocation(with: character.location.url)
    }
    
    func showOrigin() {
        router.openOrigin(with: character.origin.url)
    }
}

// MARK: - CharacterDetailsPresenter + CharacterDetailsInteractorOutputProtocol
extension CharacterDetailsPresenter: CharacterDetailsInteractorOutputProtocol {
    
    func receiveCharacter(_ character: CharacterDetails) {
        self.character = character
        view.setCharacter(character)
    }
}
