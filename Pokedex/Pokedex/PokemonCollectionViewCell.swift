//
//  PokemonCollectionViewCell.swift
//  Pokedex
//
//  Created by Will Oakley on 2/13/18.
//  Copyright © 2018 trainingprogram. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    var pokemonImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pokemonImageView = UIImageView(frame: contentView.frame)
        pokemonImageView.contentMode = .scaleAspectFill
        pokemonImageView.clipsToBounds = true
        contentView.addSubview(pokemonImageView)
    }
    
}
