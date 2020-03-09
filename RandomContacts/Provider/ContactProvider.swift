//
//  ContactProvider.swift
//  RandomContacts
//
//  Created by Yael Bilu Eran on 08/03/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import UIKit


class ContactProvider {
   
    
    static  let shared = ContactProvider()
    private let contactsArray = [ContactModel]()
    private let dispatchQueue = DispatchQueue(label: "Queue", qos: .userInteractive)
    private let apiURLAddress = "https://randomuser.me/api"
    
    
    func bringContactForIndex(_ index:Int, completion: @escaping (Int,ContactViewModel, Error?) -> Void) {
        dispatchQueue.async {
            if index == 0{ //end of recursion
                return
            }
            print("contact #\(index) start")
            self.bringContactData {[weak self](contact, error) in
                guard error == nil else { return }
                guard let contact = contact else { return }
                completion(index,contact, nil)
                print("contact #\(index) done")
                self?.bringContactForIndex(index - 1, completion: completion)
            }
        }
    }
    
    private func bringContactData(completion: @escaping (ContactViewModel?, Error?) -> Void) {
        guard let apiURL = URL(string:apiURLAddress) else {return}
        URLSession.shared.dataTask(with: apiURL) { (data, resp, error) in
            guard let data = data else { return }
            do {
                let contactsData = try JSONDecoder().decode(ContactsResultData.self, from: data)
                guard let contact  = contactsData.contacts?.first,
                      let imageUrl = URL(string: contact.picture?.large ?? "") else { return }
                var contactModel = ContactModel(contactData: contact)
               
                self.downloadImage(imageUrl) {(image, error) in
                    guard error == nil else { completion (nil, error); return }
                    contactModel.image = image
                    print("contact image download")
                    completion(ContactViewModel(contactModel), nil)
                }
            }catch {
                print("contact failed:\(error)")
                completion(nil, error)
            }
        }.resume()
    }
    
    private func downloadImage(_ url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, resp, error) in
            guard error == nil else {
                print("image download failed:\(String(describing: error))")
                return completion(nil, error)
            }
            completion(UIImage(data: data ?? Data()), nil)
        }.resume()
    }
}
