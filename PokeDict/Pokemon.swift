//
//  Pokemon.swift
//  PokeDict
//
//  Created by Madhusudhan B.R on 5/29/17.
//  Copyright © 2017 Madhusudhan. All rights reserved.
//

import Foundation

class Pokemon {
    fileprivate var _name:String!
    fileprivate var _id:String!
    
    var name: String{
        return _name
    }
    
    var id:String{
        return _id
    }
    
    init(name:String!,id:String!){
        self._name = name
        self._id = id
    }
}
