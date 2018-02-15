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
    
    var textInput: String!
    var types: [String]!
    var minAttack: Int = 0
    var minHealth: Int = 0
    var minDefense: Int = 0
    var random: Bool = false
    
    var results: [Pokemon] = []
    var pokemon: [Pokemon] = []
    var selectedPokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Search Results"
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: "pokemonCollectionCell")
        view.addSubview(collectionView)
        
        
        listView = UITableView(frame: view.frame)
        listView.delegate = self
        listView.dataSource = self
        listView.register(PokemonTableViewCell.self, forCellReuseIdentifier: "pokemonTableCell")
        
        switchSegementControl = UISegmentedControl(items: ["Grid", "List"])
        switchSegementControl.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        switchSegementControl.addTarget(self, action: #selector(switchViewStyle), for: .valueChanged)
        navigationItem.titleView = switchSegementControl
    }
    
    override func viewDidAppear(_ animated: Bool) {
        switchSegementControl.selectedSegmentIndex = 0
        print(textInput)
        print(types)
        searchForPokemon()
    }
    
    @objc func switchViewStyle(){
        if switchSegementControl.selectedSegmentIndex == 1{
            collectionView.removeFromSuperview()
            view.addSubview(listView)
        }
        else{
            listView.removeFromSuperview()
            view.addSubview(collectionView)
        }
    }
    
    func searchForPokemon(){
//        let pokemon = PokemonGenerator.getPokemonArray()
        let typesSet = Set(types)
        results.removeAll()

        for p in pokemon{
            let pTypeSet = Set(p.types as [String])
            let matchesStringInput = (p.name.lowercased().hasPrefix(textInput.lowercased()) || String(p.number) == textInput)
            var typesMatch = true
            if types.count != 0 {
                typesMatch = typesSet.isSubset(of: pTypeSet)
            }
            let rangesMatch = p.attack > minAttack && p.health > minHealth && p.defense > minDefense
            
            if (textInput.count != 0 && matchesStringInput && ( typesMatch && rangesMatch )) || (textInput.count == 0 && ( typesMatch && rangesMatch ) ) {
                results.append(p)
            }
            
        }
        print("Returned " + String(results.count) + " Pokemon")
        
        collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is UITabBarController{
            let t = segue.destination as! UITabBarController
            let d = t.viewControllers![0] as! ProfileViewController
            d.pokemon = selectedPokemon
        }
    }
}

//COLLECTION VIEW EXTENSION
extension ResultsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonCollectionCell", for: indexPath) as! PokemonCollectionViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! PokemonCollectionViewCell
        cell.pokemonLabel.text =  String(results[indexPath.row].number) + " - " + results[indexPath.row].name.components(separatedBy: " ")[0] //removes everything after first space
        cell.pokemonImageView.image = ProfileViewController.getImageForPokemon(p: results[indexPath.row]) //static in ProfileViewController
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 4 - 10, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPokemon = results[indexPath.row]
        self.performSegue(withIdentifier: "showProfile", sender: self)
    }
}

//TABLE VIEW EXTENSION
extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonTableCell", for: indexPath) as! PokemonTableViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! PokemonTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.pokemonLabel.text = results[indexPath.row].name + "\n#" + String(results[indexPath.row].number)
        cell.pokemonImageView.image = ProfileViewController.getImageForPokemon(p: results[indexPath.row]) //static in ProfileViewController
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPokemon = results[indexPath.row]
        self.performSegue(withIdentifier: "showProfile", sender: self)
    }
}


