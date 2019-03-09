//
//  FavoriteMovies.swift
//  searchMovies
//
//  Created by Mac on 3/1/19.
//  Copyright © 2019 crossover. All rights reserved.
//

import UIKit

class FavoriteMovies: UIViewController {
    
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        
        navigationController?.navigationBar.barTintColor = favoritesTableView.backgroundColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoritesTableView.reloadData()
        movie = nil
        series = nil
    }
    
    
    
    @IBAction func deleteFavorites(_ sender: Any) {
        favoritesList.removeAll()
        favoritesTableView.reloadData()
        saveFavoriteData()
    }
    
    
}


extension FavoriteMovies: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as! FavoritesDataCell
        
        cell.title.text = favoritesList[indexPath.row].title
        cell.releaseYear.text = favoritesList[indexPath.row].released
        cell.genre.text = favoritesList[indexPath.row].genre
        
        let imageURL = favoritesList[indexPath.row].poster
        let url = URL(string: imageURL)
        URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            
            if let data = data {
                DispatchQueue.main.async {
                    cell.poster.image = UIImage(data: data)
                }
            }
        }.resume()
        
        navigationController?.navigationBar.tintColor = cell.title.textColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        counter = indexPath.row
        
        if favoritesList[indexPath.row] is Movie {
            movie = favoritesList[indexPath.row] as! Movie
            print("film")
        } else {
            series = favoritesList[indexPath.row] as! Series
            print("serija")
        }
        
        gotoSelected()
    }
    
    func gotoSelected() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "segueFavorites", sender: self)
        }
    }
}
