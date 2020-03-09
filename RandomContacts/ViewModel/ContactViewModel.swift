//
//  ContactViewModel.swift
//  RandomContacts
//
//  Created by Yael Bilu Eran on 08/03/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import UIKit

struct ContactViewModel {
    let fullName:  String
    let email:     String
    let address:   String
    let phone:     String
    let mobile:    String
    let image:     UIImage?
    
    init(_ contact: ContactModel) {
        self.fullName  = contact.title+" "+contact.lastName + " " + contact.firstName
        self.email     = contact.email
        self.address   = contact.city + " " + contact.state
        self.phone     = contact.phone
        self.mobile    = contact.mobile
        self.image     = contact.image
    }
}
