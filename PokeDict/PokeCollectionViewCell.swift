//
//  PokeCollectionViewCell.swift
//  PokeDict
//
//  Created by Madhusudhan B.R on 5/29/17.
//  Copyright © 2017 Madhusudhan. All rights reserved.
//

import UIKit

class PokeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var thumbLabel: UILabel!
    
    var pokemon: Pokemon!
    
    func updateCell(_ pokemon_: Pokemon){
        self.pokemon = pokemon_
        thumbImg.image = UIImage(named: "\(pokemon_.id)")
        thumbLabel.text = pokemon_.name.capitalized
        
    }
    
}
