//
//  FavoritesCollectionViewCell.swift
//  Pokedex
//
//  Created by Tiger Chen on 2/15/18.
//  Copyright © 2018 trainingprogram. All rights reserved.
//

import UIKit

class FavoritesCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var pokemon: Pokemon!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
    }
    
}
