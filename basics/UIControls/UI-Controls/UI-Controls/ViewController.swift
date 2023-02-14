//
//  ViewController.swift
//  UI-Controls
//
//  Created by Catherine Shing on 2/13/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let button = UIButton(type: .system)
        button.setTitle("Click", for: .normal)
        // button.setTitle("Highlighted", for: .highlighted)
        button.frame = CGRect(x: 20, y: 20, width: 200, height: 100)
        button.addTarget(self, action: #selector(doSomething), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func doSomething(_ button: UIButton) {
        print("hiii")
    }

    @IBAction func clickButton(_ sender: UIButton) {
        print("click button")
    }
    
    @IBAction func toggleSwitch(_ toggleSwitch: UISwitch) {
        print(toggleSwitch.isOn)
    }
    
    @IBAction func moveSlider(_ slider: UISlider) {
        print("slider.val", slider.value)
    }
}
