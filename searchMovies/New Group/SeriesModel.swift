//
//  SeriesModel.swift
//  searchMovies
//
//  Created by Mac on 2/23/19.
//  Copyright © 2019 crossover. All rights reserved.
//

import UIKit

struct SeriesRating: Codable {
    var source: String
    var value: String
    
    enum CodingKeys: String, CodingKey {
        case source = "Source", value = "Value"
    }
}

struct Series: Codable, Selected {
    var title: String
    var year: String
    var rated: String
    var released: String
    var runtime: String
    var genre: String
    var director: String
    var writer: String
    var actors: String
    var plot: String
    var language: String
    var country: String
    var awards: String
    var poster: String
    var ratings: [SeriesRating]
    var metascore: String
    var imdbRating: String
    var imdbVotes: String
    var imdbID: String
    var type: String
    var totalSeasons: String
    var response: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title", year = "Year", rated = "Rated", released = "Released", runtime = "Runtime", genre = "Genre", director = "Director", writer = "Writer", actors = "Actors", plot = "Plot", language = "Language", country = "Country", awards = "Awards", poster = "Poster", ratings = "Ratings", metascore = "Metascore", imdbRating, imdbVotes, imdbID, type = "Type", totalSeasons, response = "Response"
    }
}

var series: Series?



extension Series {
    static func == (lhs: Selected, rhs: Series) -> Bool {
        return lhs.title == rhs.title &&
            lhs.poster == rhs.poster
    }
}
