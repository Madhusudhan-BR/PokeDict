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
    private var _move1name:String!
    private var _move2name:String!
    private var _move3name:String!
    private var _move4name:String!
    private var _move1Desc:String!
    private var _move2Desc:String!
    private var _move3Desc:String!
    private var _move4Desc:String!
    
    var move4name : String {
        if _move4name == nil {
            _move4name = ""
        }
        return _move4name
    }
    
    var move3name : String {
        if _move3name == nil {
            _move3name = ""
        }
        return _move3name
    }
    
    var move2name : String {
        if _move2name == nil {
            _move2name = ""
        }
        return _move2name
    }
    
    var move1name : String {
        if _move1name == nil {
            _move1name = ""
        }
        return _move1name
    }
    
    var move1Desc:String{
        if _move1Desc == nil{
            _move1Desc = ""
        }
        return _move1Desc
    }
    
    var move2Desc:String{
        if _move2Desc == nil{
            _move2Desc = ""
        }
        return _move2Desc
    }
    
    var move3Desc:String{
        if _move3Desc == nil{
            _move3Desc = ""
        }
        return _move3Desc
    }
    
    var move4Desc:String{
        if _move4Desc == nil{
            _move4Desc = ""
        }
        return _move4Desc
    }
    
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
                               self._desc  =  des.replacingOccurrences(of: "POKMON", with: "pokemon")
                                //des.replacingOccurrences(of: "POKMONs", with: "pokemons")
                                
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
                
                    if let  movesDict = dict["moves"] as? [Dictionary<String,AnyObject>], movesDict.count > 0 {
                        self._move1name = ""
                        self._move2name = ""
                        self._move3name = ""
                        self._move4name = ""
                        self._move4Desc = ""
                        self._move3Desc = ""
                        self._move2Desc = ""
                        self._move1Desc = ""
                        
                        self._move1name = movesDict[0]["name"] as! String
                        self._move2name = movesDict[1]["name"] as! String
                        self._move3name = movesDict[2]["name"] as! String
                        self._move4name = movesDict[3]["name"] as! String
                        
                        print("These are  the moves")
                        print(self.move1name)
                        print(self.move2name)
                        print(self.move3name)
                        print(self.move4name)
                        
                        if let movesuri1 = movesDict[0]["resource_uri"] as? String {
                            let fullmoves1uri = descriptionURL + movesuri1
                            
                            Alamofire.request(fullmoves1uri).responseJSON(completionHandler: { (response) in
                                print("this is one of the moves")
                                print(response.result.value)
                                
                                if let move1Dict = response.result.value as? Dictionary<String,AnyObject> {
                                    if let move1 = move1Dict["description"] as? String {
                                        self._move1Desc = move1
                                    }
                                }
                                complete()
                            })
                            
                        }
                        
                        if let movesuri2 = movesDict[1]["resource_uri"] as? String {
                            let fullmoves2uri = descriptionURL + movesuri2
                            
                            Alamofire.request(fullmoves2uri).responseJSON(completionHandler: { (response) in
                                print("this is one of the moves")
                                print(response.result.value)
                                
                                if let move2Dict = response.result.value as? Dictionary<String,AnyObject> {
                                    if let move2 = move2Dict["description"] as? String {
                                        self._move2Desc = move2
                                    }
                                }
                                complete()
                            })
                            
                        }
                        
                        if let movesuri3 = movesDict[2]["resource_uri"] as? String {
                            let fullmoves3uri = descriptionURL + movesuri3
                            
                            Alamofire.request(fullmoves3uri).responseJSON(completionHandler: { (response) in
                                print("this is one of the moves")
                                print(response.result.value)
                                
                                if let move3Dict = response.result.value as? Dictionary<String,AnyObject> {
                                    if let move3 = move3Dict["description"] as? String {
                                        self._move3Desc = move3
                                    }
                                }
                                complete()
                            })
                            
                        }
                        
                        if let movesuri4 = movesDict[3]["resource_uri"] as? String {
                            let fullmoves4uri = descriptionURL + movesuri4
                            
                            Alamofire.request(fullmoves4uri).responseJSON(completionHandler: { (response) in
                                print("this is one of the moves")
                                print(response.result.value)
                                
                                if let move4Dict = response.result.value as? Dictionary<String,AnyObject> {
                                    if let move4 = move4Dict["description"] as? String {
                                        self._move4Desc = move4
                                    }
                                }
                                 complete()
                            })
                           
                            
                        }
                        
                    }
            }
            
           complete()
            
        }
        
    }
}
}
