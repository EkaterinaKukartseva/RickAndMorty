//
//  EpisodeTableViewCell.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 09.12.2020.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {
    
    @IBOutlet var episode: UILabel!
    @IBOutlet var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: EpisodeModel) {
        self.name.text = model.name
        self.episode.text = model.episode
    }
    
}
