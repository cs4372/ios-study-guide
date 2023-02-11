//
//  ViewController.swift
//  UIViewController-Example
//
//  Created by Catherine Shing on 2/9/23.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showBlue(_ sender: UIButton) {
        // programatically
        let vc = ColorViewController()
        vc.set(color: UIColor.blue, name: "blue")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func showPink(_ sender: UIButton) {
        //using storyboard
        guard let vc = storyboard?.instantiateViewController(identifier: "colorvc") as? ColorView1Controller else {
            return
        }
        vc.set(color: UIColor.systemPink, name: "Pink")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBSegueAction func showPurple(_ coder: NSCoder) -> ColorView1Controller? {
        //using segue
        guard let vc = ColorView1Controller(coder: coder) else {
            return nil
        }
        vc.set(color: UIColor.purple, name: "purple")
        return vc
    }
}
