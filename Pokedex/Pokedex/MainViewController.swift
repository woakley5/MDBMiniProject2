//
//  MainViewController.swift
//  Pokedex
//
//  Created by SAMEER SURESH on 9/25/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var searchBar: UITextField!
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
    
    var searchInput: String!
    var selectedTypes: [String]!
    var minAttack: Int!
    var minDefense: Int!
    var minHealth: Int!
    var randomInput: Bool!
    
    let types = ["Bug", "Dark", "Dragon", "Electric", "Fairy", "Fighting", "Fire", "Flying", "Ghost", "Grass", "Ground", "Ice", "Normal", "Poison", "Psychic", "Rock", "Steel", "Water"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createSearchTextField()
        createTypeLabel()
        createTypesGrid()
        createAttributesLabel()
        createAttackInputBar()
        createDefenseInputBar()
        createHealthInputBar()
        createSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // reset values
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
        }
    }
    
    @objc func searchButtontapped() {
        searchInput = searchBar.text
        performSegue(withIdentifier: "showResults", sender: self)
    }
    
    @objc func randomButtonTapped() {
        randomInput = true
        performSegue(withIdentifier: "showResults", sender: self)
    }
    
    // MARK: Creation functions
    
    func createSearchTextField() {
        searchBar = UITextField(frame: CGRect(x: 20, y: 80, width: view.frame.width - 40, height: 40))
        searchBar.layer.cornerRadius = 5
        searchBar.textColor = .black
        searchBar.borderStyle = .roundedRect
        searchBar.placeholder = "Search"
        view.addSubview(searchBar)
    }
    
    func createTypeLabel() {
        typeLabel = UILabel(frame: CGRect(x: 20, y: searchBar.frame.maxY + 10, width: view.frame.width - 40, height: 40))
        typeLabel.text = "Type"
        typeLabel.font = UIFont.systemFont(ofSize: 30)
        typeLabel.textColor = .black
        view.addSubview(typeLabel)
    }
    
    func createTypesGrid() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        typesCollectionView = UICollectionView(frame: CGRect(x: 20, y: typeLabel.frame.maxY + 10, width: view.frame.width - 40, height: 150), collectionViewLayout: layout)
        typesCollectionView.register(TypeCollectionViewCell.self, forCellWithReuseIdentifier: "typeCell")
        typesCollectionView.backgroundColor = .white
        typesCollectionView.delegate = self
        typesCollectionView.dataSource = self
        view.addSubview(typesCollectionView)
    }
    
    func createAttributesLabel() {
        attributesLabel = UILabel(frame: CGRect(x: 20, y: typesCollectionView.frame.maxY + 20, width: view.frame.width - 40, height: 40))
        attributesLabel.text = "Attributes"
        attributesLabel.font = UIFont.systemFont(ofSize: 30)
        attributesLabel.textColor = .black
        view.addSubview(attributesLabel)
    }
    
    func createAttackInputBar() {
        attackLabel = UILabel(frame: CGRect(x: 0, y: attributesLabel.frame.maxY + 10, width: view.frame.width, height: 50))
        attackLabel.text = "  Minimum Attack"
        attackLabel.backgroundColor = .red
        attackLabel.textColor = .white
        view.addSubview(attackLabel)
        
        attackTextField = UITextField(frame: CGRect(x: view.frame.width - 80, y: attackLabel.frame.minY + 10, width: 70, height: 30))
        attackTextField.backgroundColor = .white
        attackTextField.borderStyle = .roundedRect
        attackTextField.placeholder = "0-200"
        view.addSubview(attackTextField)
    }
    
    func createDefenseInputBar() {
        defenseLabel = UILabel(frame: CGRect(x: 0, y: attackLabel.frame.maxY, width: view.frame.width, height: 50))
        defenseLabel.text = "  Minimum Defense"
        defenseLabel.backgroundColor = .blue
        defenseLabel.textColor = .white
        view.addSubview(defenseLabel)
        
        defenseTextField = UITextField(frame: CGRect(x: view.frame.width - 80, y: defenseLabel.frame.minY + 10, width: 70, height: 30))
        defenseTextField.backgroundColor = .white
        defenseTextField.borderStyle = .roundedRect
        defenseTextField.placeholder = "0-200"
        view.addSubview(defenseTextField)
    }
    
    func createHealthInputBar() {
        healthLabel = UILabel(frame: CGRect(x: 0, y: defenseLabel.frame.maxY, width: view.frame.width, height: 50))
        healthLabel.text = "  Minimum Health Points"
        healthLabel.backgroundColor = .green
        healthLabel.textColor = .white
        view.addSubview(healthLabel)
        
        healthTextField = UITextField(frame: CGRect(x: view.frame.width - 80, y: healthLabel.frame.minY + 10, width: 70, height: 30))
        healthTextField.backgroundColor = .white
        healthTextField.borderStyle = .roundedRect
        healthTextField.placeholder = "0-200"
        view.addSubview(healthTextField)
    }
    
    func createSearchBar() {
        searchButton = UIButton(frame: CGRect(x: 0, y: view.frame.height - 50, width: view.frame.width/2, height: 50))
        searchButton.backgroundColor = .red
        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.addTarget(self, action: #selector(searchButtontapped), for: .touchUpInside)
        view.addSubview(searchButton)
        
        randomButton = UIButton(frame: CGRect(x: view.frame.width/2, y: view.frame.height - 50, width: view.frame.width/2, height: 50))
        randomButton.backgroundColor = .red
        randomButton.setTitle("Random", for: .normal)
        randomButton.setTitleColor(.white, for: .normal)
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
        return types.count
    }
    
    //We use this method to dequeue the cell and set it up
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "typeCell", for: indexPath) as! TypeCollectionViewCell
        cell.awakeFromNib()
//        cell.delegate = self
        return cell
    }
    
    //We use this method to populate the data of a given cell
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let typeCell = cell as! TypeCollectionViewCell
        typeCell.typeImageView.image = UIImage(named: types[indexPath.item].lowercased())
        typeCell.alpha = 0.5
    }
    
    //Sets the size of the cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    //If we want something to happen when the user taps a cell, then use this method
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath.row)
        let typeCell = collectionView.cellForItem(at: indexPath) as! TypeCollectionViewCell
        typeCell.toggleSelected()
        
        let type = types[indexPath.item]
        if typeCell.chosen {
            selectedTypes.append(type)
        } else {
            selectedTypes.remove(at: selectedTypes.index(of: type)!)
        }
//        print(selectedTypes)
    }
}

