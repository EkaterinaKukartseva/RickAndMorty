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
    
    /// Получена информация о странице с сериями
    /// - Parameter info: информация о странице
    func setEpisodeList(_ info: [Episode], isNextPage: Bool)
    
    /// Получена следующая страница
    /// - Parameter state: true - есть следующая страница
    func setPageLoading(with state: Bool)
}

// MARK: - EpisodeListPaginationViewOutputProtocol
protocol EpisodeListPaginationViewOutputProtocol {
    
    init(view: EpisodeListPaginationViewInputProtocol)
    
    /// Показать список серий
    func showEpisodeList()
    
    /// Показать список серий на следующей странице
    func showEpisodeListNextPage()
    
    /// Показать детальную инфориацию о серии
    /// - Parameter id: id серии
    func showEpisodeDetails(with id: Int)
}

// MARK: - EpisodeListPaginationViewController
final class EpisodeListPaginationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: EpisodeListPaginationViewOutputProtocol?
    private let assembly: EpisodeListPaginationAssemblyProtocol = EpisodeListPaginationAssembly()
    
    private var episodes: [Episode] = []
    private var isLoadingNextPage = false

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assembly.configure(with: self)
        tableView.register(EpisodeCell.nib, forCellReuseIdentifier: EpisodeCell.identifier)
        presenter?.showEpisodeList()
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
        checkLoadingNextPage(for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeCell.identifier, for: indexPath) as! EpisodeCell
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
    
    func setEpisodeList(_ list: [Episode], isNextPage: Bool) {
        isNextPage ? append(content: list) : set(content: list)
    }
    
    func setPageLoading(with state: Bool) {
        isLoadingNextPage = state
        guard isLoadingNextPage else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.tableView.tableFooterView = UIView()
            }
            return
        }
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: CGFloat(60))
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
    }
}

// MARK: - EpisodeListPaginationViewController + private
private extension EpisodeListPaginationViewController {
    
    func set(content: [Episode]) {
        self.episodes = content
        tableView.reloadData()
    }
    
    func append(content: [Episode]) {
        let oldCount = self.episodes.count
        self.episodes.append(contentsOf: content)
        let indexPaths = (oldCount..<self.episodes.count).map { IndexPath(row: $0, section: 0) }
        setPageLoading(with: false)
        UIView.performWithoutAnimation {
            self.tableView.insertRows(at: indexPaths, with: .bottom)
        }
    }
    
    func checkLoadingNextPage(for indexPath: IndexPath) {
        guard !isLoadingNextPage else { return }
        if indexPath.row == (episodes.count - 2) {
            presenter?.showEpisodeListNextPage()
        }
    }
}
