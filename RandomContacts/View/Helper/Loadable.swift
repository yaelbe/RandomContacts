//
//  Loadable.swift
//  RandomContacts
//
//  Created by Yael Bilu Eran on 08/03/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import UIKit

protocol Loadable: class
{
    //MARK: - Properties
    var activityIndicatorView: UIActivityIndicatorView! {get set}
    
    //MARK: - Activity indicator load logic
    func initializeActivityIndicator()
    func initializeLargeActivityIndicator()
    func showIndicator()
    func hideIndicator()
}

extension Loadable where Self: UIViewController
{
    ///Implement before calling other methods
    func initializeActivityIndicator()
    {
        activityIndicatorView = UIActivityIndicatorView(style:UIActivityIndicatorView.Style.medium)
        activityIndicatorView.hidesWhenStopped = true
        
        UIView.addCenterConstraints(for: activityIndicatorView, to: view)
        showIndicator()
    }
    
    func initializeLargeActivityIndicator() {
        activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicatorView.hidesWhenStopped = true
        
        UIView.addCenterConstraints(for: activityIndicatorView, to: view)
        showIndicator()
    }
    
    func showIndicator()
    {
        guard let activityIndicatorView = activityIndicatorView else { fatalError("Call configureActivityIndicator in viewDidLoad") }
        activityIndicatorView.startAnimating()
        view.bringSubviewToFront(activityIndicatorView)
    }
    
    func hideIndicator()
    {
        guard let activityIndicatorView = activityIndicatorView else { fatalError("Call configureActivityIndicator in viewDidLoad") }
        activityIndicatorView.stopAnimating()
    }
}

extension UIView {
    static func addCenterConstraints(for view: UIView, to superView: UIView)
    {
        superView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let centerX = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: superView, attribute: .centerX, multiplier: 1.0, constant: 0)
        let centerY = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: superView, attribute: .centerY, multiplier: 1.0, constant: 0)
        superView.addConstraints([centerX,centerY])
        
        superView.setNeedsLayout()
        superView.layoutIfNeeded()
    }
}

