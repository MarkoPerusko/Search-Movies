//
//  WatchLaterMovies.swift
//  searchMovies
//
//  Created by Mac on 3/2/19.
//  Copyright © 2019 crossover. All rights reserved.
//

import UIKit

class WatchLaterMovies: UIViewController {
    
    
    @IBOutlet weak var watchLaterTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        watchLaterTableView.dataSource = self
        watchLaterTableView.delegate = self
        
        navigationController?.navigationBar.barTintColor = watchLaterTableView.backgroundColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        watchLaterTableView.reloadData()
        movie = nil
        series = nil
    }
    
    
    
    
    @IBAction func deleteWatchLater(_ sender: Any) {
        watchLaterList.removeAll()
        watchLaterTableView.reloadData()
        saveWatchLaterData()
    }
    
}


extension WatchLaterMovies: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchLaterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "watchLaterCell", for: indexPath) as! WatchLaterDataCell
        
        cell.title.text = watchLaterList[indexPath.row].title
        cell.releaseYear.text = watchLaterList[indexPath.row].released
        cell.genre.text = watchLaterList[indexPath.row].genre
        
        let imageURL = watchLaterList[indexPath.row].poster
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
        
        if watchLaterList[indexPath.row] is Movie {
            movie = watchLaterList[indexPath.row] as! Movie
            print("film")
        } else if watchLaterList[indexPath.row] is Series {
            series = watchLaterList[indexPath.row] as! Series
            print("serija")
        }
        
        goToSelected()
    }
    
    func goToSelected() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "segueWatchLater", sender: self)
        }
    }
}
