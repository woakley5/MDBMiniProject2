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
    var chosen = false
//    var delegate: TypeCollectionViewCellDelegate? = nil
    
    override func awakeFromNib() {
        typeImageView = UIImageView(frame: contentView.frame)
        typeImageView.contentMode = .scaleAspectFill
        typeImageView.clipsToBounds = true
        contentView.addSubview(typeImageView)
    }
    
    func toggleSelected() {
        chosen = !chosen
        if chosen {
            self.alpha = 1.0
        } else {
            self.alpha = 0.5
        }
    }
    
    func toggleSelected(_ selected: Bool) {
        chosen = !selected
        toggleSelected()
    }
}
