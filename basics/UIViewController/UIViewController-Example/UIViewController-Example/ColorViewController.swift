//
//  ColorViewController.swift
//  UIViewController-Example
//
//  Created by Catherine Shing on 2/10/23.
//

import UIKit

class ColorViewController: UIViewController {
    
    var label: UILabel!
    
    var color: UIColor?
    var name: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("inside view did load")
        
        view.backgroundColor = color
        
        title = name
        
        label = UILabel()
        label.text = name
        label.textColor = UIColor.white
        
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        button.setTitle("Done", for: .normal)
        button.addTarget(self, action: #selector(done), for: .touchUpInside)
    }
    
    @objc func done() {
        dismiss(animated: true, completion: nil)
    }
    
    func set(color: UIColor, name: String) {
        self.color = color
        self.name = name
        print("inside set")
    }
}
