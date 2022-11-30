//
//  CharacterUIImageView.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 24.01.2021.
//

import UIKit
import AlamofireImage

extension UIImageView {
    
    func fetchImage(from url: String) {
        guard let url = URL(string: url) else { return }
        af.setImage(withURL: url)
    }
}
