//
//  FourthViewController.swift
//  UnwindSegue
//
//  Created by Catherine Shing on 4/10/23.
//

import UIKit

class FourthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ViewController
        destinationVC.dataString = "Back from Last Screen"
    }
}
