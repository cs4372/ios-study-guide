//
//  TodoCell.swift
//  PropertyObservers
//
//  Created by Catherine Shing on 4/11/23.
//

import UIKit

class TodoCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var todo: Todo! {
        didSet {
            if todo.completed  {
                let strokeEffect: [NSAttributedString.Key : Any] = [
                    NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                    NSAttributedString.Key.strikethroughColor: UIColor.red,
                   ]

                  let strokeString = NSAttributedString(string: todo.title, attributes: strokeEffect)
                titleLabel.attributedText = strokeString
            } else {
                titleLabel.attributedText = NSMutableAttributedString(string: todo.title)
            }
        }
    }
    
}
