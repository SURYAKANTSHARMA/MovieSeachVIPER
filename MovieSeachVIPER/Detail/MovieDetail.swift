//
//  MovieDetail.swift
//  MovieSeachVIPER
//
//  Created by Suryakant Sharma on 20/08/22.
//

import Foundation

class MovieDetail: Codable {

    var title: String
    var year: String?
    var rated: String?
    var released: String?
    var runtime: String?
    var genre: String?
    var director: String?
    var writer: String?
    var actors: String?
    var plot: String?
    var language: String?
    var country: String?
    var awards: String?
    var metascore: String?
    var imdbRating: String?
    var dvd: String?
    var boxOffice: String?
    var production: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case metascore = "Metascore"
        case imdbRating = "imdbRating"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
    }

}
