//
//  ColorView1Controller.swift
//  UIViewController-Example
//
//  Created by Catherine Shing on 2/10/23.
//

import UIKit

class ColorView1Controller: UIViewController {
    
    @IBOutlet weak var colorLabel: UILabel!
    
    var color: UIColor?
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color
        colorLabel.text = name
        title = name
    }
    
    func set(color: UIColor, name: String) {
        self.color = color
        self.name = name
        print("inside set")
    }
    
    @IBAction func clickBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
