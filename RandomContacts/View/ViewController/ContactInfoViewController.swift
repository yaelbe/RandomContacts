//
//  ContactInfoViewController.swift
//  RandomContacts
//
//  Created by Yael Bilu Eran on 08/03/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import UIKit

class ContactInfoViewController: UIViewController {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mail: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var contactViewModel: ContactViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = contactViewModel.fullName
        
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.cornerRadius = 5
        
        avatar.image  = contactViewModel.image
        avatar.layer.cornerRadius = avatar.frame.size.height/2
        name.text        = contactViewModel.fullName
        address.text     = contactViewModel.address
        mail.text        = contactViewModel.email
        
        
        
    }
}
