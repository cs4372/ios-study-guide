//
//  SecondViewController.swift
//  Segue
//
//  Created by Catherine Shing on 4/5/23.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    //store the data from the first ViewController
    var labelText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let text = labelText {
            nameLabel.text = "Hello, " + text
        }
    }
}
