//
//  TypeCollectionViewCell.swift
//  Pokedex
//
//  Created by Tiger Chen on 2/13/18.
//  Copyright © 2018 trainingprogram. All rights reserved.
//

import UIKit

//protocol TypeCollectionViewCellDelegate {
//
//}

class TypeCollectionViewCell: UICollectionViewCell {
    
    var typeImageView: UIImageView!
    var typeLabel: UILabel!
    var chosen = false
//    var delegate: TypeCollectionViewCellDelegate? = nil
    
    override func awakeFromNib() {
        typeImageView = UIImageView(frame: contentView.frame)
        typeImageView.contentMode = .scaleAspectFill
        typeImageView.clipsToBounds = true
        contentView.addSubview(typeImageView)
        
        typeLabel = UILabel(frame: CGRect(x: 0, y: contentView.frame.maxY - 8, width: contentView.frame.width, height: 8))
        typeLabel.textAlignment = .center
        typeLabel.font = UIFont(name: "Pokemon GB", size: 6)
        contentView.addSubview(typeLabel)
    }
    
    func toggleSelected() {
        chosen = !chosen
        if chosen {
            self.alpha = 1.0
            typeLabel.isHidden = true
        } else {
            self.alpha = 0.5
            typeLabel.isHidden = false
        }
    }
    
    func toggleSelected(_ selected: Bool) {
        chosen = !selected
        toggleSelected()
    }
}
