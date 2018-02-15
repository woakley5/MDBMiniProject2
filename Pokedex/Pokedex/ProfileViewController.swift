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
    var statsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageDimension = view.frame.width * 0.4
        let buffer = view.frame.width/2 - imageDimension/2
        imageView = UIImageView(frame: CGRect(x: buffer, y: buffer, width: imageDimension, height: imageDimension))
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        statsTableView = UITableView(frame: CGRect(x: 0, y: view.frame.height/2, width: view.frame.width, height: view.frame.height/2))
        view.addSubview(statsTableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(pokemon.name)
        self.navigationItem.title = pokemon.name
        imageView.image = ProfileViewController.getImageForPokemon(p: pokemon)
        statsTableView.reloadData()
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

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "statCell")
        cell.textLabel?.text = "Stat " + String(indexPath.row)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.stats.count
    }
}

