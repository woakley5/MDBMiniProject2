//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Will Oakley on 2/13/18.
//  Copyright © 2018 trainingprogram. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    var pokemonImageView: UIImageView!
    var pokemonLabel: UILabel!
    var pokemonTypeImageViewOne: UIImageView!
    var pokemonTypeImageViewTwo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let d = contentView.frame.height - 20
        
        pokemonImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: d, height: d))
        pokemonImageView.contentMode = .scaleAspectFit
        pokemonImageView.clipsToBounds = true
        contentView.addSubview(pokemonImageView)
        
        pokemonLabel = UILabel(frame: CGRect(x: d + 20, y: 10, width: contentView.frame.width - d - 30, height: 50))
        pokemonLabel.textAlignment = .left
        pokemonLabel.numberOfLines = 2
        pokemonLabel.font = UIFont(name: "Pokemon GB", size: 12)
        contentView.addSubview(pokemonLabel)
        
        pokemonTypeImageViewOne = UIImageView(frame: CGRect(x: d + 20, y: 60, width: 30, height: 30))
        pokemonTypeImageViewOne.contentMode = .scaleAspectFit
        pokemonTypeImageViewOne.clipsToBounds = true
        pokemonTypeImageViewOne.alpha = 0.6
        contentView.addSubview(pokemonTypeImageViewOne)
        
        pokemonTypeImageViewTwo = UIImageView(frame: CGRect(x: d + 50, y: 60, width: 30, height: 30))
        pokemonTypeImageViewTwo.contentMode = .scaleAspectFit
        pokemonTypeImageViewTwo.clipsToBounds = true
        pokemonTypeImageViewTwo.alpha = 0.6
        contentView.addSubview(pokemonTypeImageViewTwo)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
