//
//  ViewController.swift
//  ContextMenu
//
//  Created by Catherine Shing on 6/8/23.
//

import UIKit

class ViewController: UIViewController, UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) { _ in
                let copy = UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc")) { _ in
                    print("Copy was selected")
                }
                let share = UIAction(title: "Share") { _ in
                    print("Share was selected")
                }
                let favorite = UIAction(
                    title: "Favorite",
                    image: UIImage(systemName: "stars"),
                    attributes: .disabled,
                    state: .off) { _ in
                        print("Favorite was selected")
                }
                let remove = UIAction(
                    title: "Remove",
                    image: UIImage(systemName: "trash"),
                    attributes: .destructive,
                    handler: { _ in
                        print("Remove was selected")
                })
                return UIMenu(title: "Hello Menu", children: [copy, share, favorite, remove])
            }
        }
    

        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            
            let square = UIView()
            square.translatesAutoresizingMaskIntoConstraints = false
            square.backgroundColor = .systemBlue
            view.addSubview(square)
            NSLayoutConstraint.activate([
                square.widthAnchor.constraint(equalToConstant: 200),
                square.heightAnchor.constraint(equalToConstant: 200),
                square.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                square.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
            let menuInteraction = UIContextMenuInteraction(delegate: self)
            square.addInteraction(menuInteraction)
        }
}

