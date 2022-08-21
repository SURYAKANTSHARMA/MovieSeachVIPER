//
//  Movie.swift
//  MovieSeachVIPER
//
//  Created by Suryakant Sharma on 20/08/22.
//

import Foundation

// MARK: - Movie

struct SearchResult: Codable {
    let movies: [Movie]?
    let totalResults, response: String?

    enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case totalResults
        case response = "Response"
    }
}

class Movie: Codable {

    let title: String
    let year: String?
    let imdbId: String?
    let type: String?
    let poster: String?
    var isFavourite: Bool = false {
        didSet {
        self.onChangeFavourite?(isFavourite)
     }
    }
    var onChangeFavourite: ((Bool)->Void)? = nil
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }

}

// MARK: - Helpers

extension Movie {

    var hasPoster: Bool {
        guard let poster = poster else { return false }
        return !poster.isEmpty && poster != "N/A"
    }

}
