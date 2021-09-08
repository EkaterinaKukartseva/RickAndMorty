//
//  ViewController.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 09.12.2020.
//

import UIKit

let client = Client()

class ViewController: UIViewController {
    
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    private var search = false
    
    private let characterSegue = "openCharacter"
    private let locationSegue = "openLocation"
    private let episodeSegue = "openEpisode"
    
    private let characterReuseIdentifier = "CharactersCell"
    private let locationReuseIdentifier = "LocationsCell"
    private let episodeReuseIdentifier = "EpisodesCell"
    private let noDataReuseIdentifier = "NoDataCell"
    private let loadingIdentifier = "LoadingCell"
    
    private var characters: [CharacterModel] = []
    private var locations: [LocationModel] = []
    private var episodes: [EpisodeModel] = []
    
    private var infoCharacter: Info!
    private var infoLocation: Info!
    private var infoEpisode: Info!
    
    private var currentPageCharacter = 1
    private var currentPageLocation = 1
    private var currentPageEpisode = 1
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCharacters()
        fetchLocations()
        fetchEpisodes()
    }
    
    private func fetchCharacters() {
        client.character().fetchCharacters(byPageNumber: currentPageCharacter) { [unowned self] (result) in
            switch result.self {
            case .success(let characters):
                DispatchQueue.main.async {
                    self.infoCharacter = characters.info
                    self.characters.append(contentsOf: characters.results)
                    self.currentPageCharacter += 1
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchLocations() {
        client.location().fetchLocations(byPageNumber: currentPageLocation) { [unowned self] (result) in
            switch result.self {
            case .success(let locations):
                DispatchQueue.main.async {
                    self.infoLocation = locations.info
                    self.locations.append(contentsOf: locations.results)
                    self.currentPageLocation += 1
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchEpisodes() {
        
        client.episode().fetchEpisodes(byPageNumber: currentPageEpisode) { [unowned self] (result) in
            switch result.self {
            case .success(let episodes):
                DispatchQueue.main.async {
                    self.infoEpisode = episodes.info
                    self.episodes.append(contentsOf: episodes.results)
                    self.currentPageEpisode += 1
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - IBAction
    @IBAction func segmentedAction(_ sender: Any) {
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CharacterDetailsViewController, let id = sender as? Int {
            destination.characterId = id
        } else
        
        if let destination = segue.destination as? LocationDetailsViewController, let location = sender as? LocationModel {
//            destination.location = location
        } else
        
        if let destination = segue.destination as? EpisodeViewController, let episode = sender as? EpisodeModel {
            destination.episodeModel = episode
        }
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            count = characters.count
        case 1:
            count = locations.count
        case 2:
            count = episodes.count
        default: break
            
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            if indexPath.row == characters.count - 1 && currentPageCharacter <= infoCharacter.pages, search == false {
                let cell = tableView.dequeueReusableCell(withIdentifier: loadingIdentifier, for: indexPath)
                self.fetchCharacters()
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: characterReuseIdentifier, for: indexPath) as! CharacterTableViewCell
            let character = characters[indexPath.row]
            cell.configure(model: character)
            
            cell.prepareForReuse()
            return cell
        case 1:
            if indexPath.row == locations.count - 1 && currentPageLocation <= infoLocation.pages, search == false {
                let cell = tableView.dequeueReusableCell(withIdentifier: loadingIdentifier, for: indexPath)
                self.fetchLocations()
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: locationReuseIdentifier, for: indexPath) as! LocationTableViewCell
            let location = locations[indexPath.row]
            cell.configure(model: location)
            
            cell.prepareForReuse()
            return cell
        case 2:
            if indexPath.row == episodes.count - 1 && currentPageEpisode <= infoEpisode.pages, search == false {
                let cell = tableView.dequeueReusableCell(withIdentifier: loadingIdentifier, for: indexPath)
                self.fetchEpisodes()
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: episodeReuseIdentifier, for: indexPath) as! EpisodeTableViewCell
            let episode = episodes[indexPath.row]
            cell.configure(model: episode)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: noDataReuseIdentifier, for: indexPath)
            
            cell.prepareForReuse()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            let character = characters[indexPath.row]
            performSegue(withIdentifier: characterSegue, sender: character.id)
        case 1:
            let location = locations[indexPath.row]
            performSegue(withIdentifier: locationSegue, sender: location)
        case 2:
            let episode = episodes[indexPath.row]
            performSegue(withIdentifier: episodeSegue, sender: episode)
        default: break
        }
    }
}

// MARK: - UISearchBarDelegate

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            searchCharacters()
        case 1:
            searchLocations()
        case 2:
            searchEpisodes()
        default: break
        }
    }
    
    func searchCharacters() {
        if searchBar.text?.count ?? 0 > 0 {
            characters.removeAll()
            search = true
            client.character().fetchCharacters(byName: searchBar.text!) { (result) in
                switch result.self {
                case .success(let characters):
                    DispatchQueue.main.async {
                        self.characters = characters.results
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("ERROR \(error.localizedDescription)")
                }
            }
        } else {
            search = false
            currentPageCharacter = 1
            self.characters.removeAll()
            fetchCharacters()
        }
    }
    
    func searchLocations() {
        if searchBar.text?.count ?? 0 > 0 {
            locations.removeAll()
            search = true
            client.location().fetchLocations(byName: searchBar.text!) { (result) in
                switch result.self {
                case .success(let locations):
                    DispatchQueue.main.async {
                        self.locations = locations.results
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("ERROR \(error.localizedDescription)")
                }
            }
        } else {
            search = false
            currentPageLocation = 1
            self.locations.removeAll()
            fetchLocations()
        }
    }
    
    func searchEpisodes() {
        if searchBar.text?.count ?? 0 > 0 {
            episodes.removeAll()
            search = true
            client.episode().fetchEpisodes(byName: searchBar.text!) { (result) in
                switch result.self {
                case .success(let episodes):
                    DispatchQueue.main.async {
                        self.episodes = episodes.results
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("ERROR \(error.localizedDescription)")
                }
            }
        } else {
            search = false
            currentPageEpisode = 1
            self.episodes.removeAll()
            fetchEpisodes()
        }
    }
}
