//
//  EpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 12.12.2020.
//

import UIKit

// MARK: EpisodeCollectionViewCell
class EpisodeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var episode: UILabel!
    
    var viewModel: EpisodeCollectionViewCellViewModelProtocol! {
        didSet {
            episode.text = viewModel.episodeName
        }
    }
    
}
