//
//  ListOfMovies.swift
//  searchMovies
//
//  Created by Mac on 2/21/19.
//  Copyright © 2019 crossover. All rights reserved.
//

import UIKit

class ListOfMovies: UIViewController {
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
        DispatchQueue.main.async {
            self.myTableView.reloadData()
        }
        
        navigationController?.navigationBar.barTintColor = myTableView.backgroundColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        movie = nil
        series = nil
    }
}



extension ListOfMovies: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchMovies == nil {
            return 0
        } else {
            return searchMovies!.search.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyDataCell
        
        if searchMovies != nil {
            cell.movieTitle.text = searchMovies!.search[indexPath.row].title
            cell.movieReleaseYear.text = searchMovies!.search[indexPath.row].year
            cell.movieType.text = searchMovies!.search[indexPath.row].type
            
            let imageURL = searchMovies!.search[indexPath.row].poster
            let url = URL(string: imageURL)
            URLSession.shared.dataTask(with: url!) {
                (data, response, error) in
                
                if let data = data {
                    DispatchQueue.main.async {
                        cell.moviePoster.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        counter = indexPath.row
        
        performSegue(withIdentifier: "segueSearch", sender: self)
    }
}
