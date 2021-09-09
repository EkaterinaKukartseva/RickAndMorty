//
//  EpisodesCollectionViewController.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 12.12.2020.
//

import UIKit

// MARK: - EpisodeListViewInputProtocol
protocol EpisodeListViewInputProtocol: AnyObject {}

// MARK: - EpisodeListViewOutputProtocol
protocol EpisodeListViewOutputProtocol {
    
    init(view: EpisodeListViewInputProtocol)
}

final class EpisodeListViewController: UICollectionViewController {
    
    var presenter: EpisodeListViewOutputProtocol?
    private let assembly: EpisodeListAssemblyProtocol = EpisodeListAssembly()
    
    var episodes: [EpisodeModel] = []
    var ids = [Int]()
    
    private let reuseIdentifier = "episodeCell"
    private let episodeSegue = "showEpisode"
    
    let sectionInsets = UIEdgeInsets(top: 14.0, left: 16.0, bottom: 14.0, right: 16.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        fetchEpisodesByID(ids: ids)
    }
    
    private func fetchEpisodesByID(ids: [Int]) {
        
        guard ids.count > 1 else {
            client.episode().fetchEpisode(byID: ids.first!) { (result) in
                switch result {
                case .success(let model):
                    DispatchQueue.main.async {
                        self.episodes.append(model)
                        self.collectionView.reloadData()
                    }
                case .failure(let error):
                    print("ERROR \(error.localizedDescription)")
                }
            }
            return
        }
        
        client.episode().fetchEpisodes(byID: ids) { (result) in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    model.forEach { (episode) in
                        self.episodes.append(episode)
                        self.collectionView.reloadData()
                    }
                }
            case .failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
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
        return episodes.count//ids.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EpisodeCollectionViewCell
        
        cell.episode.text = episodes[indexPath.row].episode
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let episode = episodes[indexPath.row]
        
        performSegue(withIdentifier: episodeSegue, sender: episode)
    }
}

// MARK: UICollectionViewDelegateFlowLayout

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
extension EpisodeListViewController: EpisodeListViewInputProtocol {}
