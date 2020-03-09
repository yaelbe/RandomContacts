//
//  ContactModel.swift
//  RandomContacts
//
//  Created by Yael Bilu Eran on 08/03/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import UIKit

struct ContactModel {
    var title       : String
    var firstName   : String
    var lastName    : String
    var city        : String
    var state       : String
    var email       : String
    var phone       : String
    var mobile      : String
    var image       : UIImage?
    
    init(contactData: ContactData) {
        self.title  = contactData.name?.title ?? ""
        self.firstName  = contactData.name?.first ?? ""
        self.lastName = contactData.name?.last  ?? ""
        self.city   = contactData.location?.city ?? ""
        self.state  = contactData.location?.state ?? ""
        self.email     = contactData.email ?? ""
        self.mobile    = contactData.cell ?? ""
        self.phone     = contactData.phone ?? ""
    }
}
