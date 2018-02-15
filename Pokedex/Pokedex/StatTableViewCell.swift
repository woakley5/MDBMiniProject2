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
        
        statNameLabel = UILabel(frame: CGRect(x: 20, y: 10 , width: contentView.frame.width * 0.7, height: contentView.frame.height - 20))
        contentView.addSubview(statNameLabel)
        
        statValueLabel = UILabel(frame: CGRect(x: contentView.frame.width - contentView.frame.width * 0.3 + 20, y: 10 , width: contentView.frame.width * 0.3, height: contentView.frame.height - 20))
        contentView.addSubview(statValueLabel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
