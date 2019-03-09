//
//  SearchMovies.swift
//  searchMovies
//
//  Created by Mac on 2/21/19.
//  Copyright © 2019 crossover. All rights reserved.
//

import UIKit

struct Search: Codable {
    var title: String
    var year: String
    var imdbID: String
    var type: String
    var poster: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title", year = "Year", imdbID, type = "Type", poster = "Poster"
    }
}

struct SearchMovies: Codable {
    var search: [Search]
    var totalResults: String
    var response: String
    
    enum CodingKeys: String, CodingKey {
        case search = "Search", totalResults, response = "Response"
    }
}

var searchMovies: SearchMovies?

var moviesURL: URL?




var selectedField: Any?




protocol Selected {
    var title: String { get }
    var poster: String { get }
    var rated: String { get }
    var runtime: String { get }
    var genre: String { get }
    var writer: String { get }
    var director: String { get }
    var actors: String { get }
    var plot: String { get }
    var released: String { get }
}


var favoritesList = [Selected]()
var watchLaterList = [Selected]()

