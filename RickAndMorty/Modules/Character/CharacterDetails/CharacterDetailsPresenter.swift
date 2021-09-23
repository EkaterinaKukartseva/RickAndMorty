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

    private let view: CharacterDetailsViewInputProtocol?
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
        router.openEpisodeListModule(with: character.episode.compactMap {
            let id = $0.replacingOccurrences( of:"[^0-9]", with: "", options: .regularExpression)
            return Int(id)
        })
    }
    
    func showLocation() {
        router.openLocationDetailsModule(with: character.location.url)
    }
    
    func showOrigin() {
        router.openOriginDetailsModule(with: character.origin.url)
    }
}

// MARK: - CharacterDetailsPresenter + CharacterDetailsInteractorOutputProtocol
extension CharacterDetailsPresenter: CharacterDetailsInteractorOutputProtocol {
    
    func receiveCharacter(_ character: CharacterDetails) {
        self.character = character
        view?.setCharacter(character)
    }
}
