//
//  ProfileViewController.swift
//  Pokedex
//
//  Created by Will Oakley on 2/13/18.
//  Copyright © 2018 trainingprogram. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var pokemon: Pokemon!
    
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageDimension = view.frame.width * 0.6
        let buffer = view.frame.width/2 - imageDimension/2
        imageView = UIImageView(frame: CGRect(x: buffer, y: buffer, width: imageDimension, height: imageDimension))
        view.addSubview(imageView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(pokemon.name)
        self.tabBarController?.navigationItem.title = pokemon.name
        self.tabBarItem.title = pokemon.name.components(separatedBy: " ")[0]
        imageView.image = ProfileViewController.getImageForPokemon(p: pokemon)
    }
    
    static func getImageForPokemon(p: Pokemon!) -> UIImage { //not really the best place to put this but we can move later
        let url = URL(string: p.imageUrl)
        if url != nil{
            do {
                let data = try Data(contentsOf: url!)
                return UIImage(data: data)!
                
            }
            catch _{
                print("Error getting image")
                return UIImage(named: "pokeball")!
            }
        }
        else{
            print("Broken URL for " + p.name)
            return UIImage(named: "pokeball")!
        }
    }
    

}
