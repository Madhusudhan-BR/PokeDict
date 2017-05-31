//
//  DetailViewController.swift
//  PokeDict
//
//  Created by Madhusudhan B.R on 5/30/17.
//  Copyright © 2017 Madhusudhan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var pokemon:Pokemon!
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonDesc: UILabel!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    @IBOutlet weak var pokemonDefense: UILabel!
    @IBOutlet weak var pokemonID: UILabel!
    @IBOutlet weak var pokemonWeight: UILabel!
    @IBOutlet weak var pokemonAttack: UILabel!
    @IBOutlet weak var pokemonHeight: UILabel!
    @IBOutlet weak var pokemonEvolutionLabel: UILabel!
    @IBOutlet weak var pokemonEvolutionImage2: UIImageView!
    @IBOutlet weak var pokemonEvolutionImage1: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateView(){
        pokemonName.text = pokemon.name
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
