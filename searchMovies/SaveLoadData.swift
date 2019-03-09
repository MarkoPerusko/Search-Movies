//
//  SaveLoadData.swift
//  searchMovies
//
//  Created by Mac on 3/7/19.
//  Copyright © 2019 crossover. All rights reserved.
//

import UIKit




func saveFavoriteData() {
    var jsonFavoritesData = [Data]()
    let encoder = JSONEncoder()
    
    for f in favoritesList {
        if f is Movie {
            let jsonMovie = try? encoder.encode(f as! Movie)
            jsonFavoritesData.append(jsonMovie!)
        } else if f is Series {
            let jsonSeries = try? encoder.encode(f as! Series)
            jsonFavoritesData.append(jsonSeries!)
        }
    }
    
    DispatchQueue.main.async {
        if jsonFavoritesData.count != 0 {
            for f in 0...jsonFavoritesData.count - 1 {
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                print(documentsDirectory)
                let myFileURL = documentsDirectory.appendingPathComponent("favorites\(f)").appendingPathExtension("json")
                
                do {
                    try jsonFavoritesData[f].write(to: myFileURL)
                } catch {
                    print("Error")
                }
            }
        }
    }
    
    saveNumberOfFavorites()
}

func saveNumberOfFavorites() {
    let numberOfFavorites = "\(favoritesList.count)"
    
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let mynumberOfFavoritesURL = documentsDirectory.appendingPathComponent("numberOfFavorites").appendingPathExtension("txt")
    
    do {
        try numberOfFavorites.write(to: mynumberOfFavoritesURL, atomically: true, encoding: .utf8)
    } catch {
        print("Error")
    }
}




func loadFavoriteData() {
    var numberOfFavorites = "\(favoritesList.count)"
    
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let mynumberOfFavoritesURL = documentsDirectory.appendingPathComponent("numberOfFavorites").appendingPathExtension("txt")
    
    do {
        numberOfFavorites = try String(contentsOf: mynumberOfFavoritesURL, encoding: .utf8)
    } catch {
        print("Error")
    }
    
    if let num = Int(numberOfFavorites), num != 0 {
        for f in 0...num - 1 {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let myFileURL = documentsDirectory.appendingPathComponent("favorites\(f)").appendingPathExtension("json")
            
            URLSession.shared.dataTask(with: myFileURL) {
                (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    if let m = try? decoder.decode(Movie.self, from: data) {
                        favoritesList.append(m)
                    } else if let s = try? decoder.decode(Series.self, from: data) {
                        favoritesList.append(s)
                    }
                }
            }.resume()
        }
    }
}









func saveWatchLaterData() {
    var jsonWatchLaterData = [Data]()
    let encoder = JSONEncoder()
    
    for wl in watchLaterList {
        if wl is Movie {
            let jsonMovie = try? encoder.encode(wl as! Movie)
            jsonWatchLaterData.append(jsonMovie!)
        } else if wl is Series {
            let jsonSeries = try? encoder.encode(wl as! Series)
            jsonWatchLaterData.append(jsonSeries!)
        }
    }
    
    DispatchQueue.main.async {
        if jsonWatchLaterData.count != 0 {
            for wl in 0...jsonWatchLaterData.count - 1 {
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let myFileURL = documentsDirectory.appendingPathComponent("watchLater\(wl)").appendingPathExtension("json")
                
                do {
                    try jsonWatchLaterData[wl].write(to: myFileURL)
                } catch {
                    print("Error")
                }
            }
        }
    }
    
    saveNumberOfWatchLater()
}

func saveNumberOfWatchLater() {
    let numberOfWatchLater = "\(watchLaterList.count)"
    
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let mynumberOfWatchLaterURL = documentsDirectory.appendingPathComponent("numberOfWatchLater").appendingPathExtension("txt")
    
    do {
        try numberOfWatchLater.write(to: mynumberOfWatchLaterURL, atomically: true, encoding: .utf8)
        print(numberOfWatchLater)
    } catch {
        print("Error")
    }
}




func loadWatchLaterData() {
    var numberOfWatchLater = "\(watchLaterList.count)"
    
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let mynumberOfWatchLaterURL = documentsDirectory.appendingPathComponent("numberOfWatchLater").appendingPathExtension("txt")
    
    do {
        numberOfWatchLater = try String(contentsOf: mynumberOfWatchLaterURL, encoding: .utf8)
        print(numberOfWatchLater)
    } catch {
        print("Error")
    }
    
    if let num = Int(numberOfWatchLater), num != 0 {
        for wl in 0...num - 1 {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let myFileURL = documentsDirectory.appendingPathComponent("watchLater\(wl)").appendingPathExtension("json")
            
            URLSession.shared.dataTask(with: myFileURL) {
                (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    if let m = try? decoder.decode(Movie.self, from: data) {
                        watchLaterList.append(m)
                    } else if let s = try? decoder.decode(Series.self, from: data) {
                        watchLaterList.append(s)
                    }
                }
            }.resume()
        }
    }
}
