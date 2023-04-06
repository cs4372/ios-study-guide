//
//  SecondViewController.swift
//  DelegatePattern
//
//  Created by Catherine Shing on 4/6/23.
//

import UIKit

protocol passDataDelegate {
    func sendData(data: String)
}

class SecondViewController: UIViewController {
    
    var delegate: passDataDelegate?

    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func clickBtn(_ sender: UIButton) {
        if let text = textField.text {
            delegate?.sendData(data: text)
            dismiss(animated: true, completion: nil)
        }
    }
}
