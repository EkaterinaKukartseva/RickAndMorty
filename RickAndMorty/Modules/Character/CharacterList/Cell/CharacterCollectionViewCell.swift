//
//  CharacterCollectionViewCel.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 12.12.2020.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var name: UILabel!
    @IBOutlet var imageView: CharacterImageView! {
        didSet {
            imageView.layer.cornerRadius = 10
            imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }
    
    func configure(model: Character) {
        name.text = model.name
        imageView.fetchImage(from: model.image)
    }
}
