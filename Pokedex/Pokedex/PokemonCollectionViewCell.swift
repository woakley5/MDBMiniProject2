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
    var pokemonLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pokemonImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height - 20))
        pokemonImageView.contentMode = .scaleAspectFit
        pokemonImageView.clipsToBounds = true
        contentView.addSubview(pokemonImageView)
        
        pokemonLabel = UILabel(frame: CGRect(x: 0, y: contentView.frame.height - 15, width: contentView.frame.width, height: 15))
        pokemonLabel.textAlignment = .center
        pokemonLabel.font = UIFont(name: "Helvetica", size: 10)
        contentView.addSubview(pokemonLabel)
    }
    
    
}
