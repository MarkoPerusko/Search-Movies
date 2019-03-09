//
//  SelectedMovie.swift
//  searchMovies
//
//  Created by Mac on 2/21/19.
//  Copyright © 2019 crossover. All rights reserved.
//

import UIKit

class SelectedMovie: UIViewController {
    
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieRated: UILabel!
    @IBOutlet weak var movieRuntime: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieWriter: UILabel!
    @IBOutlet weak var movieDirector: UILabel!
    @IBOutlet weak var movieActors: UILabel!
    @IBOutlet weak var moviePlot: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    
    var b = true    // If it's movie or game -> b = true. If it's series -> b = false.
    
    
    func getData() {
        
        // Access through search group
        
        if movie == nil && series == nil {
            let urlString = "http://www.omdbapi.com/?i="+searchMovies!.search[counter].imdbID+"&apikey=956702e8"
            let imageUrl = URL(string: urlString)
            
            URLSession.shared.dataTask(with: imageUrl!) {
                (data, response, error) in
                
                let decoder = JSONDecoder()
                
                if let movieApi = try? decoder.decode(Movie.self, from: data!) {
                    movie = movieApi
                    
                    self.b = true
                    
                    self.delegateValues()
                } else if let seriesApi = try? decoder.decode(Series.self, from: data!) {
                    series = seriesApi
                    
                    self.b = false
                    
                    self.delegateValues()
                }
            }.resume()
            
        // Access through favorites or watch later group
            
        } else {
            if series != nil {
                b = false
            }
            
            self.delegateValues()
        }
        self.createBarButtons()
    }
    
    func delegateValues() {
        DispatchQueue.main.async {
            if self.b {
                self.movieTitle.text = movie!.title
                
                let urlImageString = movie!.poster
                let urlImage = URL(string: urlImageString)
                URLSession.shared.dataTask(with: urlImage!) {
                    (data, response, errror) in
                    
                    if let data = data {
                        DispatchQueue.main.async {
                            self.movieImage.image = UIImage(data: data)
                        }
                    }
                }.resume()
                
                self.movieRated.text = "Rated: " + movie!.rated
                self.movieRuntime.text = "Runtime: " + movie!.runtime
                self.movieGenre.text = movie!.genre
                self.movieWriter.text = "Writer(s): " + movie!.writer
                self.movieDirector.text = "Director: " + movie!.director
                self.movieActors.text = "Actors: " + movie!.actors
                self.moviePlot.text = "Plot: " + movie!.plot
            } else {
                self.movieTitle.text = series!.title
                
                let urlImageString = series!.poster
                let urlImage = URL(string: urlImageString)
                URLSession.shared.dataTask(with: urlImage!) {
                    (data, response, errror) in
                    
                    if let data = data {
                        DispatchQueue.main.async {
                            self.movieImage.image = UIImage(data: data)
                        }
                    }
                }.resume()
                
                self.movieRated.text = "Rated: " + series!.rated
                self.movieRuntime.text = "Total Seasons: " + series!.totalSeasons
                self.movieGenre.text = series!.genre
                self.movieWriter.text = "Writer: " + series!.writer
                self.movieDirector.text = "Director: " + series!.director
                self.movieActors.text = "Actors: " + series!.actors
                self.moviePlot.text = "Plot: " + series!.plot
            }
            
            self.sizeFit()
        }
    }
    
    func sizeFit() {
        self.movieTitle.sizeToFit()
        self.movieRated.sizeToFit()
        self.movieRuntime.sizeToFit()
        self.movieGenre.sizeToFit()
        self.movieWriter.sizeToFit()
        self.movieDirector.sizeToFit()
        self.movieActors.sizeToFit()
        self.moviePlot.sizeToFit()
    }
    
    
    
    
    let favoritesButton = UIButton(type: .custom)
    let watchLaterButton = UIButton(type: .custom)
    var isFavorite = false
    var doWatchLater = false
}


extension SelectedMovie {
    
    // Creating right bar button items
    
    func createBarButtons() {
        DispatchQueue.main.async {
            self.favoritesButton.setImage(UIImage(named: "not favorites.png"), for: .normal)
            self.favoritesButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            
            self.favoritesButton.addTarget(self, action: #selector(self.addToFavoritesList), for: .touchUpInside)
            self.favoritesButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
            self.favoritesButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
            
            
            self.watchLaterButton.setImage(UIImage(named: "dont watch later.png"), for: .normal)
            self.watchLaterButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            
            self.watchLaterButton.addTarget(self, action: #selector(self.addToWatchLaterList), for: .touchUpInside)
            self.watchLaterButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
            self.watchLaterButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
            
            
            self.isSelected()
            
            
            let barButton1 = UIBarButtonItem(customView: self.favoritesButton)
            let barButton2 = UIBarButtonItem(customView: self.watchLaterButton)
            
            self.navigationItem.rightBarButtonItems = [barButton1, barButton2]
        }
    }
    
    
    // When accessing through favorites group, checking if movie/game/series is selected as favorit or watch later
    
    func isSelected() {
        if movie != nil {
            if favoritesList.contains(where: {$0 == movie!}) {
                self.favoritesButton.setImage(UIImage(named: "favorites.png"), for: .normal)
                self.isFavorite = true
            }
            
            if watchLaterList.contains(where: {$0 == movie!}) {
                self.watchLaterButton.setImage(UIImage(named: "watch later.png"), for: .normal)
                self.doWatchLater = true
            }
        } else if series != nil {
            if favoritesList.contains(where: {$0 == series!}) {
                self.favoritesButton.setImage(UIImage(named: "favorites.png"), for: .normal)
                self.isFavorite = true
            }
            
            if watchLaterList.contains(where: {$0 == series!}) {
                self.watchLaterButton.setImage(UIImage(named: "watch later.png"), for: .normal)
                self.doWatchLater = true
            }
        }
    }
    
    @objc func addToFavoritesList() {
        if movie != nil {
            let favoriteMovie = movie!
            
            if !isFavorite {
                favoritesButton.setImage(UIImage(named: "favorites.png"), for: .normal)
                
                favoritesList.append(favoriteMovie)
            } else {
                favoritesButton.setImage(UIImage(named: "not favorites.png"), for: .normal)
                
                favoritesList.removeAll(where: {$0 == favoriteMovie})
            }
        } else if series != nil {
            let favoriteSeries = series!
            
            if !isFavorite {
                favoritesButton.setImage(UIImage(named: "favorites.png"), for: .normal)
                
                favoritesList.append(favoriteSeries)
            } else {
                favoritesButton.setImage(UIImage(named: "not favorites.png"), for: .normal)
                
                favoritesList.removeAll(where: {$0 == favoriteSeries})
            }
        }
        
        saveFavoriteData()
        isFavorite = !isFavorite
    }
    
    @objc func addToWatchLaterList() {
        if movie != nil {
            let watchLaterMovie = movie!
            
            if !doWatchLater {
                watchLaterButton.setImage(UIImage(named: "watch later.png"), for: .normal)
                
                watchLaterList.append(watchLaterMovie)
            } else {
                watchLaterButton.setImage(UIImage(named: "dont watch later.png"), for: .normal)
                
                watchLaterList.removeAll(where: {$0 == watchLaterMovie})
            }
        } else if series != nil {
            let watchLaterSeries = series!
            
            if !doWatchLater {
                watchLaterButton.setImage(UIImage(named: "watch later.png"), for: .normal)
                
                watchLaterList.append(watchLaterSeries)
            } else {
                watchLaterButton.setImage(UIImage(named: "dont watch later.png"), for: .normal)
                
                watchLaterList.removeAll(where: {$0 == watchLaterSeries})
            }
        }
        
        saveWatchLaterData()
        doWatchLater = !doWatchLater
    }
}
