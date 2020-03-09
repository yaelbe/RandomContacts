//
//  ContactCell.swift
//  RandomContacts
//
//  Created by Yael Bilu Eran on 08/03/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//
import UIKit

class ContactCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    
    static let reuseIdentifier = "ContactCell"
    
    var contactViewModel: ContactViewModel! {
        didSet{
            self.fullName.text   = contactViewModel.fullName
            self.imageView.image = contactViewModel.image
            self.imageView.layer.cornerRadius = self.imageView.frame.size.height/2
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = bounds.width/10
        
        
    }

}
