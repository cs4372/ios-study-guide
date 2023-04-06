//
//  ViewController.swift
//  Segue
//
//  Created by Catherine Shing on 4/5/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
                        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToSecondViewController" {
            // store the instance of the SecondViewController
            if let destinationVC = segue.destination as? SecondViewController {
                // set the variable from the SecondViewController that will receive the data
                if let text = textField.text {
                    destinationVC.labelText = text
                }
            }
        }
    }
}
