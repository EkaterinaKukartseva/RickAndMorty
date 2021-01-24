//
//  CharactersCollectionViewControll.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 12.12.2020.
//

import UIKit

class CharactersCollectionViewController: UICollectionViewController {
    
    private let sectionInsets = UIEdgeInsets(top: 14.0, left: 16.0, bottom: 14.0, right: 16.0)
    
    private let reuseIdentifier = "residentCell"
    private let residentSegue = "showResident"
    
    private var characters: [CharacterModel] = []
    var ids = [Int]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchResidentsByID(ids: ids)
    }

    private func fetchResidentsByID(ids: [Int]) {
        client.character().fetchCharacters(byID: ids) { (result) in
            switch result {
            case .success(let model):
                
                DispatchQueue.main.async {
                    model.forEach { (character) in
                        self.characters.append(character)
                        self.collectionView.reloadData()
                    }
                }
                
            case.failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func goHomeAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CharacterViewController {
            if let resident = sender as? CharacterModel {
                destination.character = resident
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CharactersCollectionViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CharacterCollectionViewCell
    
        let resident = characters[indexPath.row]
        cell.configure(model: resident)
    
        return cell
    }

    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let resident = characters[indexPath.row]
        performSegue(withIdentifier: residentSegue, sender: resident)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CharactersCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left + sectionInsets.right + sectionInsets.top
                let availableWidth = collectionView.bounds.width - paddingSpace
                let widthPerItem = availableWidth / 2
                return CGSize(width: widthPerItem, height: widthPerItem)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.bottom
    }
}

