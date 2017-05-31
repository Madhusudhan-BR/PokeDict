//
//  ViewController.swift
//  PokeDict
//
//  Created by Madhusudhan B.R on 5/29/17.
//  Copyright © 2017 Madhusudhan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    var pokeArray = [Pokemon]()
    var filteredPokeArray = [Pokemon]()
    
    var searchMode = false
    
    var musicPlayer = AVAudioPlayer()
    @IBOutlet weak var pokeCollection: UICollectionView!
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokeCollection.dataSource = self
        pokeCollection.delegate = self
        pokeSearchBar.delegate = self
        pokeSearchBar.returnKeyType = UIReturnKeyType.done
        loadFromCsv()
        initMusic()
    }
    
    func initMusic(){
        let musicPath = Bundle.main.path(forResource: "pokeMusic", ofType: "mp3")!
        
        do{
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: musicPath)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        }
        catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func musicButtonPressed(_ sender: Any) {
        if musicPlayer.isPlaying == true{
            musicPlayer.pause()
            (sender as! UIButton).alpha = 0.2
        }
        else {
            musicPlayer.play()
            (sender as! UIButton).alpha = 1.0
        }
    }
    func loadFromCsv(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            for row in rows {
                let name = row["identifier"]!
                let id = Int(row["id"]!)!
                print(id)
                let poke = Pokemon(name: name, id: "\(id)")
                pokeArray.append(poke)
            }
            
        }catch let err as NSError {
            print(err)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let poke : Pokemon!
        if searchMode{
             poke = filteredPokeArray[indexPath.row]
            
        }
        else {
            poke = pokeArray[indexPath.row]
        }
        
        performSegue(withIdentifier: "DetailViewController", sender: poke)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "DetailViewController"{
            if let DetailVC = segue.destination as? DetailViewController {
                if let poke = sender as? Pokemon {
                    DetailVC.pokemon = poke
                }
            }
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if searchMode {
            return filteredPokeArray.count
        }
        else {
        return pokeArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCollectionViewCell {
            
            //let pokemon = Pokemon(name: "PokePoke", id: "\(indexPath.row)")
//            let pokemon = pokeArray[indexPath.row]
//            cell.updateCell(pokemon)
            let poke : Pokemon!
            if searchMode {
                poke = filteredPokeArray[indexPath.row]
                cell.updateCell(poke)
            }
            else{
                poke = pokeArray[indexPath.row]
                cell.updateCell(poke)

            }
            return cell
        }
        
        else {
            
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        if searchBar.text == nil || searchBar.text == "" {
            view.endEditing(true)
            searchMode = false
            pokeCollection.reloadData()
        }
        else {
            searchMode = true
            
            let text = searchText.lowercased()
            
            filteredPokeArray = pokeArray.filter({$0.name.range(of: text) != nil})
            pokeCollection.reloadData()
            
        }
    }
}

