//
//  CharacterListViewController.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 12.12.2020.
//

import UIKit

// MARK: - CharacterListViewInputProtocol
protocol CharacterListViewInputProtocol: AnyObject {
    
    func setCharacterList(_ list: [Character])
}

// MARK: - CharacterListViewOutnputProtocol
protocol CharacterListViewOutnputProtocol {
    
    init(view: CharacterListViewInputProtocol)
    
    func showCharacterList(with ids: [Int])
    
    func showCharacterDetails(with id: Int)
}

// MARK: - CharacterListViewController
class CharacterListViewController: UICollectionViewController {
    
    var presenter: CharacterListViewOutnputProtocol!
    private let assembly: CharacterListAssemblyProtocol = CharacterListAssembly()
    
    private let sectionInsets = UIEdgeInsets(top: 14.0, left: 16.0, bottom: 14.0, right: 16.0)
    
    private let reuseIdentifier = "residentCell"
    
    private var characters: [Character] = []
    var ids = [Int]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assembly.configure(with: self)
        presenter.showCharacterList(with: ids)
    }
    
    @IBAction func goHomeAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CharacterDetailsViewController {
            if let id = sender as? Int {
                destination.characterId = id
            }
        }
    }
}

// MARK: - CharacterListViewController + UICollectionViewDataSource
extension CharacterListViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CharacterCollectionViewCell
    
        let resident = characters[indexPath.row]
        cell.configure(model: resident)
    
        return cell
    }
}

// MARK: - CharacterListViewController + UICollectionViewDelegate
extension CharacterListViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let resident = characters[indexPath.row]
        presenter.showCharacterDetails(with: resident.id)
    }
}

// MARK: - CharacterListViewController + UICollectionViewDelegateFlowLayout
extension CharacterListViewController: UICollectionViewDelegateFlowLayout {
    
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

// MARK: - CharacterListViewController + CharacterListViewInputProtocol
extension CharacterListViewController: CharacterListViewInputProtocol {
    
    func setCharacterList(_ list: [Character]) {
        characters = list
        collectionView.reloadData()
    }
}
