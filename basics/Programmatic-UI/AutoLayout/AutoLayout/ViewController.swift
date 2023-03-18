//
//  ViewController.swift
//  AutoLayout
//
//  Created by Catherine Shing on 3/18/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Button", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 100),
            button.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
    }
    
    @objc func clickButton() {
        let vc = SecondViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

