//
//  ViewController.swift
//  UnwindSegue
//
//  Created by Catherine Shing on 4/10/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dataPassedLabel: UILabel!
    
    var dataString = "This is the first controller"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        dataPassedLabel.text = dataString
    }
    
    @IBAction func unwindToFirst(_ sender: UIStoryboardSegue) {}
}

