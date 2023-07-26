//
//  ImageTableViewCell.swift
//  Download+Cache-Images
//
//  Created by Catherine Shing on 7/25/23.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
  
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var badgeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var representedIdentifier: String = ""
        
    var title: String? {
      didSet {
        titleLabel.text = title
      }
    }
    var image: UIImage? {
      didSet {
          mainImageView.image = image
      }
    }
    
    var badge: UIImage? {
      didSet {
        badgeImageView.image = badge
      }
    }
}

