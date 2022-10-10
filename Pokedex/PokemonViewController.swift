//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Waldi Febrianda on 10/10/22.
//

import UIKit

class PokemonViewController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var type1label: UILabel!
    @IBOutlet var type2label: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        type1label.text = ""
        type2label.text = ""
        
        let url = URL(string: pokemon.url)
        guard let u = url else {
            return
        }
        
        URLSession.shared.dataTask(with: u) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let pokemonData = try JSONDecoder().decode(PokemonData.self, from: data)
                
                DispatchQueue.main.async {
                    self.nameLabel.text = self.pokemon.name
                    self.numberLabel.text = String(format: "#%03d", pokemonData.id)
                    
                    for typeEntry in pokemonData.types {
                        if typeEntry.slot == 1 {
                            self.type1label.text = typeEntry.type.name
                        }
                        else if typeEntry.slot == 2 {
                            self.type2label.text = typeEntry.type.name
                        }
                    }
                }
            }
            catch let error {
                print("\(error)")
            }
        }.resume()
    }
}
