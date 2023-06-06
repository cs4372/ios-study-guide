//
//  MovieCollectionViewCell.swift
//  UICollectionView1
//
//  Created by Catherine Shing on 6/5/23.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
         super.awakeFromNib()
         
         layer.cornerRadius = 10
         layer.masksToBounds = true
         layer.borderWidth = 5
         layer.borderColor = UIColor.lightGray.cgColor
     }
    
    func setup(with movie: Movie) {
        imageView.image = movie.image
        titleLabel.text = movie.title
    }
}
