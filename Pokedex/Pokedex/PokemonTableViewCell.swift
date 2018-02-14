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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let d = contentView.frame.height - 20
        
        pokemonImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: d, height: d))
        pokemonImageView.contentMode = .scaleAspectFit
        pokemonImageView.clipsToBounds = true
        contentView.addSubview(pokemonImageView)
        
        pokemonLabel = UILabel(frame: CGRect(x: d + 10, y: 10, width: 200, height: d))
        pokemonLabel.textAlignment = .center
        contentView.addSubview(pokemonLabel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
