//
//  ContactsViewController.swift
//  RandomContacts
//
//  Created by Yael Bilu Eran on 08/03/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import UIKit

private let reuseIdentifier = ContactCell.reuseIdentifier

class ContactsViewController: UICollectionViewController, Loadable {
    
    private let infoSegueIdentifier = "SegueToInfo"
    var activityIndicatorView: UIActivityIndicatorView!
    var data = [ContactViewModel]()
    let collectionInsets = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
    let numberOfContacts = 10
    
    private var selectedItem: ContactViewModel? {
        didSet{
            performSegue(withIdentifier: infoSegueIdentifier, sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
        // Register cell classes
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        collectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        fetchData()
    }
    
    private func fetchData() {
        initializeLargeActivityIndicator()
        
        ContactProvider.shared.bringContactForIndex(numberOfContacts) { [weak self] (index,contact, error) in
            guard error == nil else {
                print("contacts index: \(index)failed: \(String(describing: error))")
                return
            }
            guard let self = self else {return}
            self.data.append(contact)
            DispatchQueue.main.async {
                self.hideIndicator()
                self.collectionView.insertItems(at: [IndexPath(row: self.numberOfContacts - index, section: 0)])
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ContactCell{
            let contactViewModel  = data[indexPath.row]
            cell.contactViewModel = contactViewModel
            return cell
        }
        return UICollectionViewCell()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == infoSegueIdentifier {
            if let detailsVC = segue.destination as? ContactInfoViewController{
                detailsVC.contactViewModel = selectedItem
            }
        }
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = data[indexPath.row]
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return collectionInsets
    }
}

extension ContactsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width - collectionInsets.left - collectionInsets.right
        let size = collectionViewWidth/2 - collectionInsets.top - collectionInsets.bottom
        return CGSize(width: size  , height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionInsets.top + collectionInsets.bottom
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionInsets.left + collectionInsets.right
    }
    
}

