//
//  MainViewController.swift
//  Pokedex
//
//  Created by SAMEER SURESH on 9/25/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    var searchBar: UITextField!
    var favoritesLabel: UILabel!
    var favoritesCollectionView: UICollectionView!
    var typeLabel: UILabel!
    var typesCollectionView: UICollectionView!
    var attributesLabel: UILabel!
    var attackLabel: UILabel!
    var attackTextField: UITextField!
    var defenseLabel: UILabel!
    var defenseTextField: UITextField!
    var healthLabel: UILabel!
    var healthTextField: UITextField!
    var searchButton: UIButton!
    var randomButton: UIButton!
    var tap: UIGestureRecognizer!
    
    var searchInput: String!
    var selectedTypes: [String]!
    var minAttack: Int!
    var minDefense: Int!
    var minHealth: Int!
    var randomInput: Bool!
    var selectedPokemon: Pokemon!
    
    let types = ["Bug", "Dark", "Dragon", "Electric", "Fairy", "Fighting", "Fire", "Flying", "Ghost", "Grass", "Ground", "Ice", "Normal", "Poison", "Psychic", "Rock", "Steel", "Water"]
    var pokemon = PokemonGenerator.getPokemonArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.barTintColor = .red
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Pokemon Solid", size: 30)!]
        navigationItem.title = "Pokédex"
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        createSearchTextField()
        createFavoritesLabel()
        createFavoritesBar()
        createTypeLabel()
        createTypesGrid()
        createAttributesLabel()
        createAttackInputBar()
        createDefenseInputBar()
        createHealthInputBar()
        createSearchBar()
        
        sortPokemon()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // reset values
        if searchBar != nil {
            searchBar.text = ""
            attackTextField.text = ""
            defenseTextField.text = ""
            healthTextField.text = ""
        }
        
        searchInput = ""
        selectedTypes = []
        minAttack = 0
        minDefense = 0
        minHealth = 0
        randomInput = false
        
        for indexPath in typesCollectionView.indexPathsForVisibleItems {
            let cell = typesCollectionView.cellForItem(at: indexPath) as! TypeCollectionViewCell
            cell.toggleSelected(false)
        }
        favoritesCollectionView.reloadData()
        print("Favorites Array:")
        print(UserDefaults.standard.array(forKey: "favorites"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ResultsViewController {
            let vc = segue.destination as? ResultsViewController
            vc?.textInput = searchInput
            vc?.types = selectedTypes
            vc?.minAttack = minAttack
            vc?.minDefense = minDefense
            vc?.minHealth = minHealth
            vc?.random = randomInput
            vc?.pokemon = pokemon
        } else if segue.destination is ProfileViewController {
            let vc = segue.destination as? ProfileViewController
            vc?.pokemon = selectedPokemon
        }
    }
    
    @objc func searchButtontapped() {
        if searchBar.text != "" {
            searchInput = searchBar.text
        }
        if attackTextField.text != "" {
            minAttack = Int(attackTextField.text!)
        }
        if defenseTextField.text != "" {
            minDefense = Int(defenseTextField.text!)
        }
        if healthTextField.text != "" {
            minHealth = Int(healthTextField.text!)
        }
        performSegue(withIdentifier: "showResults", sender: self)
    }
    
    @objc func randomButtonTapped() {
        randomInput = true
        performSegue(withIdentifier: "showResults", sender: self)
    }
    
    @objc func addGestureRecognizer(sender: UITextField) {
        print("tapped")
        
        if sender != searchBar && view.frame.origin.y == 0.0 {
            slideViewUp()
            tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tap)
        } else if sender == searchBar {
            tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tap)
        }
    }
    
    func dismissKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
        view.removeGestureRecognizer(tap)
        slideViewDown()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        view.removeGestureRecognizer(tap)
        slideViewDown()
        return false
    }
    
    func slideViewUp() {
        let hiddenY = view.frame.height - healthLabel.frame.maxY - 216.0
        UIView.animate(withDuration: 0.4, animations: {self.view.frame.origin.y += hiddenY})
    }
    
    func slideViewDown() {
        UIView.animate(withDuration: 0.2, animations: {self.view.frame.origin.y = 0.0})
    }
    
    func sortPokemon() {
        pokemon = pokemon.sorted(by: {p1,p2 in
            if p1.number == p2.number {
                return p1.name < p2.name
            }
            return p1.number < p2.number
        })
    }
    
    // MARK: Creation functions
    
    func createSearchTextField() {
        searchBar = UITextField(frame: CGRect(x: 20, y: 80, width: view.frame.width - 40, height: 40))
        searchBar.layer.cornerRadius = 5
        searchBar.textColor = .black
        searchBar.borderStyle = .roundedRect
//        searchBar.placeholder = "Search"
        let attr = [NSFontAttributeName: UIFont(name: "Pokemon GB", size: 15)!]
        searchBar.attributedPlaceholder = NSAttributedString(string: "Search", attributes: attr)
        searchBar.addTarget(self, action: #selector(addGestureRecognizer), for: .touchDown)
        searchBar.delegate = self
        view.addSubview(searchBar)
    }
    
    func createFavoritesLabel() {
        favoritesLabel = UILabel(frame: CGRect(x: 20, y: searchBar.frame.maxY + 5, width: view.frame.width - 40, height: 40))
        favoritesLabel.text = "Favorites"
        favoritesLabel.font = UIFont(name: "Pokemon GB", size: 20)
        favoritesLabel.textColor = .black
        view.addSubview(favoritesLabel)
    }
    
    func createFavoritesBar() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        favoritesCollectionView = UICollectionView(frame: CGRect(x: 20, y: favoritesLabel.frame.maxY + 5, width: view.frame.width - 40, height: 50), collectionViewLayout: layout)
        favoritesCollectionView.register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: "favoritesCell")
        favoritesCollectionView.backgroundColor = .white
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
        favoritesCollectionView.showsHorizontalScrollIndicator = false
        view.addSubview(favoritesCollectionView)
    }
    
    func createTypeLabel() {
        typeLabel = UILabel(frame: CGRect(x: 20, y: favoritesCollectionView.frame.maxY + 5, width: view.frame.width - 40, height: 40))
        typeLabel.text = "Types"
        typeLabel.font = UIFont(name: "Pokemon GB", size: 20)
        typeLabel.textColor = .black
        view.addSubview(typeLabel)
    }
    
    func createTypesGrid() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        typesCollectionView = UICollectionView(frame: CGRect(x: 20, y: typeLabel.frame.maxY + 5, width: view.frame.width - 40, height: 150), collectionViewLayout: layout)
        typesCollectionView.register(TypeCollectionViewCell.self, forCellWithReuseIdentifier: "typeCell")
        typesCollectionView.backgroundColor = .white
        typesCollectionView.delegate = self
        typesCollectionView.dataSource = self
        view.addSubview(typesCollectionView)
    }
    
    func createAttributesLabel() {
        attributesLabel = UILabel(frame: CGRect(x: 20, y: typesCollectionView.frame.maxY + 5, width: view.frame.width - 40, height: 40))
        attributesLabel.text = "Attributes"
        attributesLabel.font = UIFont(name: "Pokemon GB", size: 20)
        attributesLabel.textColor = .black
        view.addSubview(attributesLabel)
    }
    
    func createAttackInputBar() {
        attackLabel = UILabel(frame: CGRect(x: 0, y: attributesLabel.frame.maxY + 5, width: view.frame.width, height: 50))
        attackLabel.text = " Minimum Attack"
        attackLabel.font = UIFont(name: "Pokemon GB", size: 15)
        attackLabel.backgroundColor = UIColor(red: 1.0, green: 59/255, blue: 48/255, alpha: 1.0)
        attackLabel.textColor = .white
        view.addSubview(attackLabel)
        
        attackTextField = UITextField(frame: CGRect(x: view.frame.width - 90, y: attackLabel.frame.minY + 10, width: 70, height: 30))
        attackTextField.backgroundColor = .white
        attackTextField.borderStyle = .roundedRect
//        attackTextField.placeholder = "0-200"
        let attr = [NSFontAttributeName: UIFont(name: "Pokemon GB", size: 10)!]
        attackTextField.attributedPlaceholder = NSAttributedString(string: "0-200", attributes: attr)
        attackTextField.keyboardType = .numberPad
        attackTextField.addTarget(self, action: #selector(addGestureRecognizer), for: .touchDown)
        view.addSubview(attackTextField)
    }
    
    func createDefenseInputBar() {
        defenseLabel = UILabel(frame: CGRect(x: 0, y: attackLabel.frame.maxY, width: view.frame.width, height: 50))
        defenseLabel.text = " Minimum Defense"
        defenseLabel.font = UIFont(name: "Pokemon GB", size: 15)
        defenseLabel.backgroundColor = UIColor(red: 0.0, green: 122/255, blue: 1.0, alpha: 1.0)
        defenseLabel.textColor = .white
        view.addSubview(defenseLabel)
        
        defenseTextField = UITextField(frame: CGRect(x: view.frame.width - 90, y: defenseLabel.frame.minY + 10, width: 70, height: 30))
        defenseTextField.backgroundColor = .white
        defenseTextField.borderStyle = .roundedRect
//        defenseTextField.placeholder = "0-200"
        let attr = [NSFontAttributeName: UIFont(name: "Pokemon GB", size: 10)!]
        defenseTextField.attributedPlaceholder = NSAttributedString(string: "0-200", attributes: attr)
        defenseTextField.keyboardType = .numberPad
        defenseTextField.addTarget(self, action: #selector(addGestureRecognizer), for: .touchDown)
        view.addSubview(defenseTextField)
    }
    
    func createHealthInputBar() {
        healthLabel = UILabel(frame: CGRect(x: 0, y: defenseLabel.frame.maxY, width: view.frame.width, height: 50))
        healthLabel.text = " Minimum Health"
        healthLabel.font = UIFont(name: "Pokemon GB", size: 15)
        healthLabel.backgroundColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1.0)
        healthLabel.textColor = .white
        view.addSubview(healthLabel)
        
        healthTextField = UITextField(frame: CGRect(x: view.frame.width - 90, y: healthLabel.frame.minY + 10, width: 70, height: 30))
        healthTextField.backgroundColor = .white
        healthTextField.borderStyle = .roundedRect
//        healthTextField.placeholder = "0-200"
        let attr = [NSFontAttributeName: UIFont(name: "Pokemon GB", size: 10)!]
        healthTextField.attributedPlaceholder = NSAttributedString(string: "0-200", attributes: attr)
        healthTextField.keyboardType = .numberPad
        healthTextField.addTarget(self, action: #selector(addGestureRecognizer), for: .touchDown)
        view.addSubview(healthTextField)
    }
    
    func createSearchBar() {
        searchButton = UIButton(frame: CGRect(x: 0, y: healthLabel.frame.maxY, width: view.frame.width/2, height: view.frame.height - healthLabel.frame.maxY))
        searchButton.backgroundColor = .red
        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.titleLabel?.font = UIFont(name: "Pokemon GB", size: 20)
        searchButton.addTarget(self, action: #selector(searchButtontapped), for: .touchUpInside)
        view.addSubview(searchButton)
        
        randomButton = UIButton(frame: CGRect(x: view.frame.width/2, y: healthLabel.frame.maxY, width: view.frame.width/2, height: view.frame.height - healthLabel.frame.maxY))
        randomButton.backgroundColor = .red
        randomButton.setTitle("Random", for: .normal)
        randomButton.setTitleColor(.white, for: .normal)
        randomButton.titleLabel?.font = UIFont(name: "Pokemon GB", size: 20)
        randomButton.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
        view.addSubview(randomButton)
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //Specifying the number of sections in the collectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //Specifying the number of cells in the given section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == typesCollectionView {
            return types.count
        } else {
            if let array = UserDefaults.standard.array(forKey: "favorites") {
                print(array.count)
                return array.count
            }
            return 0 //was 10, dont know why
        }
    }
    
    //We use this method to dequeue the cell and set it up
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == typesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "typeCell", for: indexPath) as! TypeCollectionViewCell
            cell.awakeFromNib()
//            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoritesCell", for: indexPath) as! FavoritesCollectionViewCell
            cell.awakeFromNib()
            return cell
        }
    }
    
    //We use this method to populate the data of a given cell
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == typesCollectionView {
            let typeCell = cell as! TypeCollectionViewCell
            typeCell.typeImageView.image = UIImage(named: types[indexPath.item].lowercased())
            typeCell.alpha = 0.5
            typeCell.typeLabel.text = types[indexPath.item]
        } else {
            let favCell = cell as! FavoritesCollectionViewCell
            if let array = UserDefaults.standard.array(forKey: "favorites") {
                let i = array[indexPath.item] as! Int
                favCell.pokemon = pokemon[i]
                favCell.imageView.image = ProfileViewController.getImageForPokemon(p: pokemon[i])
            } else {
                favCell.pokemon = pokemon[indexPath.item]
                favCell.imageView.image = ProfileViewController.getImageForPokemon(p: pokemon[indexPath.item])
            }
        }
    }
    
    //Sets the size of the cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    //If we want something to happen when the user taps a cell, then use this method
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == typesCollectionView {
            let typeCell = collectionView.cellForItem(at: indexPath) as! TypeCollectionViewCell
            typeCell.toggleSelected()
            
            let type = types[indexPath.item]
            if typeCell.chosen {
                selectedTypes.append(type)
            } else {
                selectedTypes.remove(at: selectedTypes.index(of: type)!)
            }
        } else {
            let favCell = collectionView.cellForItem(at: indexPath) as! FavoritesCollectionViewCell
            selectedPokemon = favCell.pokemon
            performSegue(withIdentifier: "showProfileFromFavorite", sender: self)
        }
    }
}

