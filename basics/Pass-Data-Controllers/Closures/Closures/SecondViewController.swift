//
//  SecondViewController.swift
//  Closures
//
//  Created by Catherine Shing on 4/6/23.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    func getText() -> String {
        //returns the pet that is selected, as a String
        if let text = textField.text {
            return text
        }
        return ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func textClick(_ sender: UIButton) {
        if let vc = presentingViewController as? ViewController {
               //before dismissing the Form ViewController, pass the data inside the closure
                 dismiss(animated: true, completion: {
                     vc.setText(self.getText())
             })
         }
     }
}
