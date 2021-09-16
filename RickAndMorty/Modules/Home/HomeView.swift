//
//  HomeView.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 14/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import UIKit

// MARK: - HomeViewInputProtocol
protocol HomeViewInputProtocol: AnyObject {}

// MARK: - HomeViewOutputProtocol
protocol HomeViewOutputProtocol {
    
    init(view: HomeViewInputProtocol)
}

// MARK: - HomeViewController
final class HomeViewController: UIViewController {

    var presenter: HomeViewOutputProtocol?
    private let assembly: HomeAssemblyProtocol = HomeAssembly()

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assembly.configure(with: self)
        embedCharacterList()
    }
    
    @IBAction func didTapSegmentedControl(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            embedCharacterList()
        case 1:
            embedLocationList()
        case 2:
            embedEpisodeList()
        default:
            break
        }
    }
}

// MARK: - HomeViewController + HomeViewInputProtocol
extension HomeViewController: HomeViewInputProtocol {}

// MARK: - HomeViewController + Private
extension HomeViewController {
    
    func embedCharacterList() {
        let storyboard = UIStoryboard(name: "CharacterListPagination", bundle: .main)
        if let viewController = storyboard.instantiateViewController(identifier: "CharacterListPaginationViewController")
            as? CharacterListPaginationViewController {
            embed(viewController)
        }
    }
    
    func embedEpisodeList() {
        let storyboard = UIStoryboard(name: "EpisodesList", bundle: .main)
        if let viewController = storyboard.instantiateViewController(identifier: "EpisodeListViewController")
            as? EpisodeListViewController {
            embed(viewController)
        }
    }
    
    func embedLocationList() {
        let storyboard = UIStoryboard(name: "LocationListPagination", bundle: .main)
        if let viewController = storyboard.instantiateViewController(identifier: "LocationListPaginationViewController")
            as? LocationListPaginationViewController {
            embed(viewController)
        }
    }
    
    func embed(_ viewController: UIViewController) {
        addChild(viewController)
        viewController.view.frame = contentView.bounds
        contentView.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
}
