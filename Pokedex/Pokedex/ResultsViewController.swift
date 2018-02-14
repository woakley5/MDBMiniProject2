//
//  ResultsViewController.swift
//  Pokedex
//
//  Created by Will Oakley on 2/13/18.
//  Copyright © 2018 trainingprogram. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var listView: UITableView!
    var switchSegementControl: UISegmentedControl!
    
    var textInput: String = "Bulbasaur"
    var types: [String] = ["Grass"]
    var minAttack: Int = 0
    var minHealth: Int = 0
    var minDefense: Int = 0
    
    var results: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: "pokemonCell")
        view.addSubview(collectionView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchForPokemon()
    }
    
    func searchForPokemon(){
        let pokemon = PokemonGenerator.getPokemonArray()
        let typesSet = Set(types)
        results.removeAll()
        
        for p in pokemon{
            let pTypeSet = Set(p.types as [String])
            let matchesStringInput = (p.name == textInput || String(p.number) == textInput)
            let typesMatch = typesSet.isSubset(of: pTypeSet)
            let rangesMatch = p.attack > minAttack && p.health > minHealth && p.defense > minDefense
            
            if matchesStringInput && typesMatch && rangesMatch {
                results.append(p)
            }
            
        }
        print("Returned " + String(results.count) + " Pokemon")
        
        collectionView.reloadData()
    }
}

extension ResultsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonCell", for: indexPath) as! PokemonCollectionViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        do {
            let data = try Data(contentsOf: URL(string: results[indexPath.row].imageUrl)!)
            let cell = cell as! PokemonCollectionViewCell
            cell.pokemonImageView.image = UIImage(data: data)
        }
        catch _{
            print("Error getting image")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 200)
    }
}


