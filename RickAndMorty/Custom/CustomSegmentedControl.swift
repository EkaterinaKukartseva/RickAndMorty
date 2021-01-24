//
//  CustomSegmentedControl.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 13.12.2020.
//

import UIKit

class CustomSegmentedControl: UISegmentedControl {

    override func draw(_ rect: CGRect) {
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "PrimaryTextColor")!], for: UIControl.State.selected)

        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "SecondaryTextColor")!], for: UIControl.State.normal)
    }
    

}
