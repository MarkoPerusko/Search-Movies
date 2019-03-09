//
//  ViewController.swift
//  searchMovies
//
//  Created by Mac on 2/21/19.
//  Copyright © 2019 crossover. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var enterMovieTitle: UITextField!
    @IBOutlet weak var noResults: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        loadFavoriteData()
        loadWatchLaterData()
        
        
        navigationController?.navigationBar.barTintColor = enterMovieTitle.backgroundColor
        navigationController?.navigationBar.tintColor = enterMovieTitle.textColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        enterMovieTitle.text = ""
        noResults.text = ""
    }
    
    
    
    
    @IBAction func search(_ sender: Any) {
        getData()
    }
}


extension ViewController {
    func getData() {
        let urlString = "http://www.omdbapi.com/?s="+enterMovieTitle.text!+"&apikey=956702e8"
        let urlMovie = urlString.replacingOccurrences(of: " ", with: "+")
        let urlMovie2 = urlMovie.replacingOccurrences(of: "'", with: "%27")
        
        
        moviesURL = URL(string: urlMovie2)
        
        URLSession.shared.dataTask(with: moviesURL!) {
            (data, response, error) in
            
            if let data = data {
                let decoder = JSONDecoder()
                
                if let sm = try? decoder.decode(SearchMovies.self, from: data) {
                    
                    searchMovies = sm
                    
                    self.goToListOfMovies()
                } else {
                    DispatchQueue.main.async {
                        self.noResults.text = "No results found"
                    }
                }
            }
            }.resume()
    }
    
    func goToListOfMovies() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "segue1", sender: self)
        }
    }
}

