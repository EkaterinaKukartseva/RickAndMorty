//
//  EpisodeListPaginationView.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 16/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import UIKit

// MARK: - EpisodeListPaginationViewInputProtocol
protocol EpisodeListPaginationViewInputProtocol: AnyObject {
    
    func setEpisodeList(_ list: InfoEpisode)
}

// MARK: - EpisodeListPaginationViewOutputProtocol
protocol EpisodeListPaginationViewOutputProtocol {
    
    init(view: EpisodeListPaginationViewInputProtocol)
    
    func showEpisodeList(by page: Int)
    
    func showEpisodeDetails(with id: Int)
}

// MARK: - EpisodeListPaginationViewController
final class EpisodeListPaginationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: EpisodeListPaginationViewOutputProtocol?
    private let assembly: EpisodeListPaginationAssemblyProtocol = EpisodeListPaginationAssembly()
    
    private var info: Info!
    private var currentPageEpisode = 1
    private var episodes: [Episode] = []

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assembly.configure(with: self)
        tableView.register(UINib(nibName: "LoadingCell", bundle: .main), forCellReuseIdentifier: "LoadingCell")
        tableView.register(UINib(nibName: "EpisodeCell", bundle: .main), forCellReuseIdentifier: "EpisodeCell")
        presenter?.showEpisodeList(by: currentPageEpisode)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodeDetailsViewController {
            if let id = sender as? Int {
                destination.episodeId = id
            }
        }
    }
}

// MARK: - EpisodeListPaginationViewController + UITableViewDataSource
extension EpisodeListPaginationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == episodes.count - 1 && currentPageEpisode <= info.pages {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath)
            presenter?.showEpisodeList(by: currentPageEpisode)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath) as! EpisodeCell
        let episode = episodes[indexPath.row]
        cell.configure(model: episode)
        return cell
    }
}

// MARK: - EpisodeListPaginationViewController + UITableViewDelegate
extension EpisodeListPaginationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episodes[indexPath.row]
        presenter?.showEpisodeDetails(with: episode.id)
    }
}

// MARK: - EpisodeListPaginationViewController + EpisodeListPaginationViewInputProtocol
extension EpisodeListPaginationViewController: EpisodeListPaginationViewInputProtocol {
    
    func setEpisodeList(_ list: InfoEpisode) {
        episodes.append(contentsOf: list.results)
        info = list.info
        currentPageEpisode += 1
        tableView.reloadData()
    }
}
