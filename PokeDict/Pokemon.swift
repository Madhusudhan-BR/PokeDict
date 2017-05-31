//
//  Pokemon.swift
//  PokeDict
//
//  Created by Madhusudhan B.R on 5/29/17.
//  Copyright © 2017 Madhusudhan. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name:String!
    private var _id:String!
    private var _desc:String!
    private var _type:String!
    private var _defence:String!
    private var _height:String!
    private var _weight:String!
    private var _baseAttack:String!
    private var _nextEvolution:String! 
    
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
