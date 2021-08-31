//
//  LocationViewController.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 11.12.2020.
//

import UIKit

class LocationViewController: UIViewController {

//    var location: LocationModel!
    
    @IBOutlet var name: UILabel!
    @IBOutlet var type: UILabel!
    @IBOutlet var dimension: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        name.text = "location.name"
        type.text = "location.type"
        dimension.text = "location.dimension"
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destination = segue.destination as? CharactersCollectionViewController else { return }
        
//        for residentUrl in location.residents {
//            let residentID = residentUrl.replacingOccurrences( of:"[^0-9]", with: "", options: .regularExpression)
//            
//            if let id = Int(residentID) {
//                destination.ids.append(Int(id))
//            }
//        }
    }
    
}
