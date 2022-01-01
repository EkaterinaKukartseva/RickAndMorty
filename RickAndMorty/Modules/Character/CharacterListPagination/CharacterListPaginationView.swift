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
    
    /// Получена информация о странице с персонажами
    /// - Parameter info: информация о странице
    func setCharacterList(_ list: [Character], isNextPage: Bool)
    
    /// Получена следующая страница
    /// - Parameter state: true - есть следующая страница
    func setPageLoading(with state: Bool)
}

// MARK: - CharacterListPaginationViewOutputProtocol
protocol CharacterListPaginationViewOutputProtocol {
    
    /// Инициализация презентера  модуля `CharacterListPagination`
    /// - Parameters:
    ///   - view: `CharacterListPaginationView`
    init(view: CharacterListPaginationViewInputProtocol)
    
    /// Показать список персонажей
    func showCharacterList()
    
    /// Показать список серий на следующей странице
    func showEpisodeListNextPage()
    
    /// Показать детальную инфориацию о персонаже
    /// - Parameter id: id персонажа
    func showCharacterDetails(with id: Int)
}

// MARK: - CharacterListPaginationViewController
final class CharacterListPaginationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: CharacterListPaginationViewOutputProtocol?
    private let assembly: CharacterListPaginationAssemblyProtocol = CharacterListPaginationAssembly()
    
    private var characters: [Character] = []
    private var isLoadingNextPage = false

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assembly.configure(with: self)
        tableView.register(CharacterTableViewCell.nib, forCellReuseIdentifier: CharacterTableViewCell.identifier)
        tableView.rowHeight =  UITableView .automaticDimension
        tableView.estimatedRowHeight =  200
        presenter?.showCharacterList()
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
        checkLoadingNextPage(for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as! CharacterTableViewCell
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
    
    func setCharacterList(_ list: [Character], isNextPage: Bool) {
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
private extension CharacterListPaginationViewController {
    
    func set(content: [Character]) {
        self.characters = content
        tableView.reloadData()
    }
    
    func append(content: [Character]) {
        let oldCount = self.characters.count
        self.characters.append(contentsOf: content)
        let indexPaths = (oldCount..<self.characters.count).map { IndexPath(row: $0, section: 0) }
        setPageLoading(with: false)
        UIView.performWithoutAnimation {
            self.tableView.insertRows(at: indexPaths, with: .bottom)
        }
    }
    
    func checkLoadingNextPage(for indexPath: IndexPath) {
        guard !isLoadingNextPage else { return }
        if indexPath.row == (characters.count - 2) {
            presenter?.showEpisodeListNextPage()
        }
    }
}
