//
//  SecondViewController.swift
//  Segues
//
//  Created by Catherine Shing on 2/19/23.
//

import UIKit

class SecondViewController: UIViewController {
    
    var name = ""
    var clickedRow = 0
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = String(clickedRow)
        
    }
}
