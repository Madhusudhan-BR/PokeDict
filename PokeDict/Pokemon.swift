//
//  Pokemon.swift
//  PokeDict
//
//  Created by Madhusudhan B.R on 5/29/17.
//  Copyright © 2017 Madhusudhan. All rights reserved.
//

import Foundation
import  Alamofire

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
    private var _pokemonURL:String!
    private var _pokemonEvolutionImageString:String!
    
    var pokemonEvolutionImageString: String {
        if _pokemonEvolutionImageString == nil {
            _pokemonEvolutionImageString = ""
        }
        return _pokemonEvolutionImageString
    }
    var desc : String {
        if _desc == nil {
            _desc = ""
        }
        return _desc
    }
    
    var type : String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defence : String {
        if _defence == nil {
            _defence = ""
            return _defence
        }
        else {
        return _defence
        }
    }
    
    var height : String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight : String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var baseAttack : String{
        if _baseAttack == nil {
            _baseAttack = ""
        }
        return _baseAttack
    }
    
    var nextEvolution:String {
        if _nextEvolution == nil {
            _nextEvolution = ""
        }
        return _nextEvolution
    }
    
    var name: String{
        return _name
    }
    
    var id:String{
        return _id
    }
    
    init(name:String!,id:String!){
        self._name = name
        self._id = id
        self._pokemonURL = "\(URL_BASE)\(_id!)/"
    }
    
    func downloadJSON(complete : @escaping downloadCompleted){
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            print(response.result.value)
            
            if let dict = response.result.value as? Dictionary<String,AnyObject> {
                if let attack = dict["attack"] as? Double{
                    self._baseAttack = "\(attack)"
                }
                if let defense = dict["defense"] as? Double{
                    self._defence = "\(defense)"
                }
                if let height = dict["height"] as? String{
                    
                    self._height = height
                }
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                }
                
                print(self._baseAttack)
                print(self._defence)
                print(self._height)
                print(self._weight)
                
                
                if let types = dict["types"] as? [Dictionary<String,String>] {
                    
                    self._type = ""
                    if types.count > 0 {
                        self._type = types[0]["name"]?.capitalized
                    }
                     if types.count > 1 {
                        for x in 1..<types.count {
                            if let tp = types[x]["name"]?.capitalized
                            {
                            self._type! += "/\(tp)"
                            }
                        }
                    }
                  
                    print(self.type)
                }
                if let descriptionsDict = dict["descriptions"] as? [Dictionary<String, AnyObject>] {
                    print(descriptionsDict)
                    if  let descriptionsURI = descriptionsDict[0]["resource_uri"] as? String{
                        print(descriptionsURI)
                        let fullDescURL = descriptionURL+descriptionsURI
                        
                        Alamofire.request(fullDescURL).responseJSON(completionHandler: { (response) in
                            print("THis is from second CALL")
                            print(response.result.value)
                            if let descriptionResponse = response.result.value as? Dictionary<String,AnyObject> {
                                let des = descriptionResponse["description"] as! String
                                des.replacingOccurrences(of: "POKMON", with: "pokemon")
                                self._desc = des
                                print("This is the description received!!")
                                print(self.desc)
                            }
                            complete()
                        })
                        
                        
                    }
                    
                }
                
                if let evolutionDict = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutionDict.count > 0 {
                    
                    if let to = evolutionDict[0]["to"] as? String{
                        if to.range(of: "mega") == nil {
                        print("This is the next evolution")
                        let to2 = "Evolves to : \(to)"
                        self._nextEvolution = to2
                        }
                        else {
                            self._nextEvolution = ""
                        }
                        
                }
                    if let resource_uri = evolutionDict[0]["resource_uri"] as? String {
                        let fullResourceURI = descriptionURL + resource_uri
                        
                        Alamofire.request(fullResourceURI).responseJSON(completionHandler: { (response) in
                            print("This is the last JSON call")
                            print(response.result.value)
                            if let responseDict = response.result.value as? Dictionary<String, AnyObject> {
                                if let pokedexID = responseDict["pkdx_id"] as? Int {
                                    print(pokedexID)
                                    self._pokemonEvolutionImageString = "\(pokedexID)"
                                }
                            }
                            complete()
                        })
                    }
                
            }
            
           complete()
            
        }
        
    }
}
}
