//
//  StatTableViewCell.swift
//  Pokedex
//
//  Created by Will Oakley on 2/14/18.
//  Copyright © 2018 trainingprogram. All rights reserved.
//

import UIKit

class StatTableViewCell: UITableViewCell {

    var statNameLabel: UILabel!
    var statValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        statNameLabel = UILabel(frame: CGRect(x: 20, y: 10 , width: 300, height: self.frame.height - 20))
        statNameLabel.font = UIFont(name: "Pokemon GB", size: 12)
        contentView.addSubview(statNameLabel)
        
        statValueLabel = UILabel(frame: CGRect(x: statNameLabel.frame.width, y: 10 , width: 40, height: self.frame.height - 20))
        statValueLabel.font = UIFont(name: "Pokemon GB", size: 12)
        statValueLabel.textAlignment = .right
        contentView.addSubview(statValueLabel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
