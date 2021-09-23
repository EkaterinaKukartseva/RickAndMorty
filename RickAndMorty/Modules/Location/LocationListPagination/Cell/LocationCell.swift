//
//  LocationTableViewCell.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 09.12.2020.
//

import UIKit

// MARK: - LocationCell
final class LocationCell: UITableViewCell {
    
    @IBOutlet var type: UILabel!
    @IBOutlet var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: Location) {
        self.name.text = model.name
        self.type.text = model.dimension
    }
    
}
