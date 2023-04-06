//
//  ViewController.swift
//  DelegatePattern
//
//  Created by Catherine Shing on 4/5/23.
//

import UIKit

class ViewController: UIViewController, passDataDelegate {

    @IBOutlet weak var labelText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func sendData(data: String) {
        labelText.text = data
      }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "MySegueIdentifier" {
             if let destinationVC = segue.destination as? SecondViewController {
                 destinationVC.delegate = self
             }
         }
     }
}
