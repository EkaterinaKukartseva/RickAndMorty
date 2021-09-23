//
//  UITableViewCell + Extension.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 17.09.2021.
//

import UIKit

extension UITableViewCell {
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
