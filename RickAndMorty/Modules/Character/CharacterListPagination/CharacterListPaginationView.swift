//
//  CharacterListPaginationView.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 16/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import UIKit

// MARK: - CharacterListPaginationViewInputProtocol
protocol CharacterListPaginationViewInputProtocol: AnyObject {
    
    func setCharacterList(_ list: InfoCharacter)
}

// MARK: - CharacterListPaginationViewOutputProtocol
protocol CharacterListPaginationViewOutputProtocol {
    
    init(view: CharacterListPaginationViewInputProtocol)
    
    func showAllCharacterList(by page: Int)
    
    func showCharacterDetails(with: Int)
}

// MARK: - CharacterListPaginationViewController
final class CharacterListPaginationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: CharacterListPaginationViewOutputProtocol?
    private let assembly: CharacterListPaginationAssemblyProtocol = CharacterListPaginationAssembly()
    
    private var info: Info!
    private var currentPageCharacter = 1
    private var characters: [Character] = []

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assembly.configure(with: self)
        presenter?.showAllCharacterList(by: currentPageCharacter)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CharacterDetailsViewController {
            if let id = sender as? Int {
                destination.characterId = id
            }
        }
    }
}

// MARK: - CharacterListPaginationViewController + UITableViewDataSource
extension CharacterListPaginationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == characters.count - 1 && currentPageCharacter <= info.pages {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath)
            presenter?.showAllCharacterList(by: currentPageCharacter)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as! CharacterTableViewCell
        cell.configure(model: characters[indexPath.row])
        return cell
    }
}

// MARK: - CharacterListPaginationViewController + UITableViewDelegate
extension CharacterListPaginationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let resident = characters[indexPath.row]
        presenter?.showCharacterDetails(with: resident.id)
    }
}

// MARK: - CharacterListPaginationViewController + CharacterListPaginationViewInputProtocol
extension CharacterListPaginationViewController: CharacterListPaginationViewInputProtocol {
    
    func setCharacterList(_ list: InfoCharacter) {
        characters.append(contentsOf: list.results)
        info = list.info
        currentPageCharacter += 1
        tableView.reloadData()
    }
}
