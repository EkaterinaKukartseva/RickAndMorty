//
//  EpisodesCollectionViewController.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 12.12.2020.
//

import UIKit

// MARK: - EpisodeListViewInputProtocol
protocol EpisodeListViewInputProtocol: AnyObject {
    
    func setEpisodeList(_ list: [Episode])
}

// MARK: - EpisodeListViewOutputProtocol
protocol EpisodeListViewOutputProtocol {
    
    init(view: EpisodeListViewInputProtocol)
    
    func showEpisodeList(with ids: [Int])
    
    func showEpisodeList(with id: Int)
    
    func showEpisodeDetails(with id: Int)
}

// MARK: - EpisodeListViewController
final class EpisodeListViewController: UICollectionViewController {
    
    var presenter: EpisodeListViewOutputProtocol?
    private let assembly: EpisodeListAssemblyProtocol = EpisodeListAssembly()
    
    var episodes: [Episode] = []
    var ids = [Int]()
    
    private let reuseIdentifier = "episodeCell"
    
    let sectionInsets = UIEdgeInsets(top: 14.0, left: 16.0, bottom: 14.0, right: 16.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assembly.configure(with: self)
        if ids.count > 1 {
            presenter?.showEpisodeList(with: ids)
        } else {
            presenter?.showEpisodeList(with: ids[0])
        }
    }
    
    @IBAction func goHome(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destionation = segue.destination as? EpisodeViewController {
            if let episode = sender as? EpisodeModel {
                destionation.episodeModel = episode
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EpisodeCollectionViewCell
        cell.episode.text = episodes[indexPath.row].episode
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let episode = episodes[indexPath.row]
        presenter?.showEpisodeDetails(with: episode.id)
    }
}

// MARK: EpisodeListViewController + UICollectionViewDelegateFlowLayout
extension EpisodeListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var paddingSpace = sectionInsets.left + sectionInsets.right + sectionInsets.top * 2
        var availableWidth = collectionView.bounds.width - paddingSpace
        var widthPerItem = availableWidth / 3
        let heightPerItem = widthPerItem
        
        if episodes.count == 1 {
            paddingSpace = sectionInsets.left + sectionInsets.right
            availableWidth = collectionView.bounds.width - paddingSpace
            widthPerItem = availableWidth
        } else if episodes.count == 2 {
            paddingSpace = sectionInsets.left + sectionInsets.right + sectionInsets.top
            availableWidth = collectionView.bounds.width - paddingSpace
            widthPerItem = availableWidth / 2
        }
        
        return CGSize(width: widthPerItem, height: heightPerItem)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.bottom
    }
    
}

// MARK: - EpisodeListViewController + EpisodeListViewInputProtocol
extension EpisodeListViewController: EpisodeListViewInputProtocol {
    
    func setEpisodeList(_ list: [Episode]) {
        episodes = list
        collectionView.reloadData()
    }
}
