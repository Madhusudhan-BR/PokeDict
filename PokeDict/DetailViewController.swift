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
    @IBOutlet weak var move2: UILabel!
    @IBOutlet weak var move1: UILabel!
    @IBOutlet weak var move4: UILabel!
    @IBOutlet weak var move3: UILabel!
    
    @IBOutlet weak var movesView: UIView!
    @IBOutlet weak var moveDesc1: UILabel!
    
    @IBOutlet weak var moveDesc2: UILabel!
    
    @IBOutlet weak var moveDesc3: UILabel!
    
    
    @IBOutlet weak var moveDesc4: UILabel!
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    @IBAction func segmentAction(_ sender: Any) {
        if segmentController.selectedSegmentIndex == 0 {
            movesView.isHidden = true
        }
        else
        {
            movesView.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemon.downloadJSON {
            
            
            print("inside download JSON")
            self.updateView()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func updateView(){
        pokemonName.text = pokemon.name
        pokemonID.text = pokemon.id
        pokemonImage.image = UIImage(named: "dragon")
        pokemonAttack.text = pokemon.baseAttack
        pokemonDefense.text = pokemon.defence
        pokemonHeight.text = pokemon.height
        pokemonWeight.text = pokemon.weight
        pokemonEvolutionImage1.image = UIImage(named: "dragon")
        pokemonType.text = pokemon.type
        pokemonDesc.text = pokemon.desc
        if pokemon.nextEvolution == "" {
            pokemonEvolutionLabel.text = "No further Evolutions"
            pokemonEvolutionImage2.isHidden = true
        } else {
        pokemonEvolutionLabel.text = pokemon.nextEvolution
        }
        pokemonEvolutionImage2.image = UIImage(named: "dragon")
        move1.text = pokemon.move1name
        move2.text = pokemon.move2name
        move3.text = pokemon.move3name
        move4.text = pokemon.move4name
        moveDesc1.text = pokemon.move1Desc
        moveDesc2.text = pokemon.move2Desc
        moveDesc3.text = pokemon.move3Desc
        moveDesc4.text = pokemon.move4Desc
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
