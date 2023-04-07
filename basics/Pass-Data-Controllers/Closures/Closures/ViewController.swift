//
//  ViewController.swift
//  Closures
//
//  Created by Catherine Shing on 4/6/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func setText(_ text: String) {
         //override the label with the parameter received in this method
        textLabel.text = text
       }
}

