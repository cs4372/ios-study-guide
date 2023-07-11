//
//  UIViewController+Alert.swift
//  PassThroughSubjects
//
//  Created by Catherine Shing on 7/11/23.
//

import UIKit

extension UIViewController {
    
    func showBlocked() {
        
        let alert = UIAlertController(title: "Ooops",
                                      message: "Thought you were tough right? Well guess what you're banned",
                                      preferredStyle: .alert)
        self.present(alert,
                     animated: true)
    }
}
