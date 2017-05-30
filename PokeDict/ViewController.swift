//
//  ViewController.swift
//  PokeDict
//
//  Created by Madhusudhan B.R on 5/29/17.
//  Copyright © 2017 Madhusudhan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    var pokeArray = [Pokemon]()
    var musicPlayer = AVAudioPlayer()
    @IBOutlet weak var pokeCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokeCollection.dataSource = self
        pokeCollection.delegate = self
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
        
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCollectionViewCell {
            
            //let pokemon = Pokemon(name: "PokePoke", id: "\(indexPath.row)")
            let pokemon = pokeArray[indexPath.row]
            cell.updateCell(pokemon)
            
            return cell
        }
        
        else {
            
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
    }
}

