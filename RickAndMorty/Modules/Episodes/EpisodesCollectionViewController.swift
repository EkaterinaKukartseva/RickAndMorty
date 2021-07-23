//
//  EpisodesCollectionViewController.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 12.12.2020.
//

import UIKit

// MARK: EpisodesCollectionViewController
class EpisodesCollectionViewController: UICollectionViewController {
    
    private let episodeSegue = "showEpisode"
    private let reuseIdentifier = "episodeCell"
    private let sectionInsets = UIEdgeInsets(top: 14.0, left: 16.0, bottom: 14.0, right: 16.0)
    
    var ids = [Int]()
    
    private var viewModel: EpisodesViewModelProtocol! {
        didSet {
            if ids.count > 1 {
                viewModel.fetchEpisodes(by: ids) {
                    self.collectionView.reloadData()
                }
            } else {
                viewModel.fetchEpisode(by: ids.first!) {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = EpisodesViewModel()
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
}

// MARK: - EpisodesCollectionViewController + UICollectionViewDataSource
extension EpisodesCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EpisodeCollectionViewCell
        let cellViewModel = viewModel.cellViewModel(at: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
}

// MARK: - EpisodesCollectionViewController + UICollectionViewDelegate
extension EpisodesCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let episode = viewModel.episode(at: indexPath)
        performSegue(withIdentifier: episodeSegue, sender: episode)
    }
}

// MARK: EpisodesCollectionViewController + UICollectionViewDelegateFlowLayout
extension EpisodesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var paddingSpace = sectionInsets.left + sectionInsets.right + sectionInsets.top * 2
        var availableWidth = collectionView.bounds.width - paddingSpace
        var widthPerItem = availableWidth / 3
        let heightPerItem = widthPerItem
        
        if viewModel.episodes.count == 1 {
            paddingSpace = sectionInsets.left + sectionInsets.right
            availableWidth = collectionView.bounds.width - paddingSpace
            widthPerItem = availableWidth
        } else if viewModel.episodes.count == 2 {
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
        sectionInsets.bottom
    }
    
}
