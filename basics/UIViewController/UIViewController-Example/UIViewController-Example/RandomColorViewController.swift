//
//  RandomColorViewController.swift
//  UIViewController-Example
//
//  Created by Catherine Shing on 2/11/23.
//

import UIKit

class RandomColorViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let color = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        view.backgroundColor = color
    }
}
