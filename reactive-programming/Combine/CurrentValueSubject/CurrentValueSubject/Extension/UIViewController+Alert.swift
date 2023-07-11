//
//  UIViewController+Alert.swift
//  CurrentValueSubject
//
//  Created by Catherine Shing on 7/10/23.
//

import UIKit

extension UIViewController {
    
    func showFailed(message: String) {
        
        let alert = UIAlertController(title: "Failed",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(.init(title: "Ok",
                              style: .cancel))
        self.present(alert,
                     animated: true)
    }
}
