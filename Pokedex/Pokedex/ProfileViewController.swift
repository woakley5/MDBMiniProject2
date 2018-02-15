//
//  ProfileViewController.swift
//  Pokedex
//
//  Created by Will Oakley on 2/13/18.
//  Copyright © 2018 trainingprogram. All rights reserved.
//

import UIKit
import WebKit

class ProfileViewController: UIViewController {

    var pokemon: Pokemon!
    
    var imageView: UIImageView!
    var statsTableView: UITableView!
    var bioLabel: UILabel!
    var typeImages: [UIImageView] = []
    var favoriteButton: UIButton!
    var webView: WKWebView!
    var isFavorite: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageDimension = view.frame.width * 0.32
        let buffer = view.frame.width/2 - imageDimension/2
        imageView = UIImageView(frame: CGRect(x: 40, y: buffer, width: imageDimension, height: imageDimension))
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        let circle = UIView(frame: CGRect(x: 15, y: buffer - 25, width: imageDimension + 50, height: imageDimension + 50))
        circle.backgroundColor = UIColor.clear
        circle.layer.cornerRadius = (imageDimension + 50)/2
        circle.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        circle.layer.borderWidth = 7
        view.addSubview(circle)
        
        let typesLabel = UILabel(frame: CGRect(x: view.frame.width/2 + 10, y: view.frame.height * 0.18 - 30, width: 100, height: 20))
        typesLabel.text = "Types:"
        view.addSubview(typesLabel)
        
        favoriteButton = UIButton(frame: CGRect(x: view.frame.width - view.frame.width/4 - 75, y: view.frame.height * 0.32, width: 150, height: 30))
        favoriteButton.setTitleColor(.blue, for: .normal)
        favoriteButton.addTarget(self, action: #selector(saveAsFavoriteButtonTapped), for: .touchUpInside)
        view.addSubview(favoriteButton)
        
        statsTableView = UITableView(frame: CGRect(x: 0, y: view.frame.height/2, width: view.frame.width, height: view.frame.height/2))
        statsTableView.delegate = self
        statsTableView.dataSource = self
        view.addSubview(statsTableView)
        statsTableView.register(StatTableViewCell.self, forCellReuseIdentifier: "statCell")
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(pokemon.name)
        self.navigationItem.title = pokemon.name
        imageView.image = ProfileViewController.getImageForPokemon(p: pokemon)
        statsTableView.reloadData()
        
        var x = view.frame.width/2 + 10
        var y = view.frame.height * 0.18
        for (i, p) in pokemon.types.enumerated() {
            let image = UIImageView(frame: CGRect(x: x, y: y, width: 50, height: 50))
            image.image = UIImage(named: p.lowercased())
            view.addSubview(image)
            typeImages.append(image)
            x = x + 50
            if i % 3 == 0 && i > 0 {
                x = view.frame.width/2 + 60
                y += 60
            }
        }
        
        let  favArray = UserDefaults.standard.array(forKey: "favorites") as? Array<Int>
        if favArray != nil { //array exists
            if favArray!.contains(where: {$0 == pokemon.number}){
                print("Already favorited")
                isFavorite = true
                favoriteButton.setTitle("Remove Favorite", for: .normal)
            }
            else{
                isFavorite = false
                favoriteButton.setTitle("Add as Favorite", for: .normal)
            }
        }
        else{
            favoriteButton.setTitle("Add as Favorite", for: .normal)
            isFavorite = false
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        for p in typeImages{
            p.removeFromSuperview()
        }
        typeImages.removeAll()
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
    
    @objc func saveAsFavoriteButtonTapped(){
        if isFavorite{
            if let array = UserDefaults.standard.array(forKey: "favorites") { //array exists
                var a = array as! Array<Int>
                let index = a.index(of: pokemon.number)
                a.remove(at: index!)
                UserDefaults.standard.set(a, forKey: "favorites")
            }
            else{
                let a = [pokemon.number]
                UserDefaults.standard.set(a, forKey: "favorites")
            }
            favoriteButton.setTitle("Add as Favorite", for: .normal)
            isFavorite = false
        }
        else{
            if let array = UserDefaults.standard.array(forKey: "favorites") { //array exists
                var a = array
                a.append(pokemon.number)
                UserDefaults.standard.set(a, forKey: "favorites")
            }
            else{
                let a = [pokemon.number]
                UserDefaults.standard.set(a, forKey: "favorites")
            }
            isFavorite = true
            favoriteButton.setTitle("Remove Favorite", for: .normal)
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statCell", for: indexPath) as! StatTableViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let c = cell as! StatTableViewCell
        c.statNameLabel.text = pokemon.statNames[indexPath.row]
        c.statValueLabel.text = String(pokemon.stats[indexPath.row])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.stats.count
    }
}

