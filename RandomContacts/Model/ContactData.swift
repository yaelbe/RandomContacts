//
//  ContactData.swift
//  RandomContacts
//
//  Created by Yael Bilu Eran on 08/03/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import Foundation

struct ContactsResultData : Codable {
    let contacts : [ContactData]?

    enum CodingKeys: String, CodingKey {
        case contacts = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        contacts = try values.decodeIfPresent([ContactData].self, forKey: .contacts)
    }
}

struct ContactData: Codable {
    let name     : Name?
    let location : Location?
    let email    : String?
    let phone    : String?
    let cell     : String?
    let picture  : Picture?
 
    enum CodingKeys: String, CodingKey {
        case name     = "name"
        case location = "location"
        case email    = "email"
        case phone    = "phone"
        case cell     = "cell"
        case picture  = "picture"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name     = try values.decodeIfPresent(Name.self, forKey: .name)
        location = try values.decodeIfPresent(Location.self, forKey: .location)
        email    = try values.decodeIfPresent(String.self, forKey: .email)
        phone    = try values.decodeIfPresent(String.self, forKey: .phone)
        cell     = try values.decodeIfPresent(String.self, forKey: .cell)
        picture  = try values.decodeIfPresent(Picture.self, forKey: .picture)
    }
}

struct Picture : Codable {
    let large  :    String?
    let medium :    String?
    let thumbnail : String?

    enum CodingKeys: String, CodingKey {
        case large     = "large"
        case medium    = "medium"
        case thumbnail = "thumbnail"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        large     = try values.decodeIfPresent(String.self, forKey: .large)
        medium    = try values.decodeIfPresent(String.self, forKey: .medium)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
    }
}

struct Location : Codable {
    //let street : String?
    let city  : String?
    let state : String?

    enum CodingKeys: String, CodingKey {

        //case street = "street"
        case city  = "city"
        case state = "state"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //street = try values.decodeIfPresent(String.self, forKey: .street)
        city  = try values.decodeIfPresent(String.self, forKey: .city)
        state = try values.decodeIfPresent(String.self, forKey: .state)
    }
}

struct Name : Codable {
    let title : String?
    let first : String?
    let last  : String?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case first = "first"
        case last  = "last"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        first = try values.decodeIfPresent(String.self, forKey: .first)
        last  = try values.decodeIfPresent(String.self, forKey: .last)
    }
}
