//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 09.12.2020.
//

import UIKit

// MARK: - CharacterTableViewCell
class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet var characterImageView: CharacterImageView! {
        didSet {
            characterImageView.contentMode = .scaleAspectFit
            characterImageView.clipsToBounds = true
        }
    }
    
    @IBOutlet var name: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var gender: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: Character) {
        name.text = model.name
        
        var attr = NSMutableAttributedString(string: "\u{2022} ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        
        if model.status == "Alive" {
            attr = NSMutableAttributedString(string: "\u{2022} ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.green])
        } else if model.status == "Dead" {
            attr = NSMutableAttributedString(string: "\u{2022} ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
        }
        
        let attrString = NSAttributedString(string: model.status)
        
        attr.append(attrString)
        
        status.attributedText = attr
        gender.text = model.gender
        characterImageView.fetchImage(from: model.image)
    }
    
}
