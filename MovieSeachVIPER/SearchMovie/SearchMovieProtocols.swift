//
//  SearchMovieProtocols.swift
//  MovieSeachVIPER
//
//  Created by Suryakant Sharma on 20/08/22.
//

import UIKit

protocol MovieInteractorInterface: AnyObject {
    var presenter: MovieSearchPresenterInterface? {get set}

    func fetchItems(searchText: String,
                    callback: @escaping (Result<[Movie], Error>) -> Void)
    func fetchImage(for url: URL, callback: @escaping (Result<UIImage, Error>) -> Void)
}

protocol MovieSearchPresenterInterface: AnyObject {
    func fetchItems(searchText: String)
    func cellTapped(at: Movie)
    func fetchImage(for url: URL, callback: @escaping (Result<(UIImage, URL), Error>) -> Void)
    func favouriteButtonTapped()
}

protocol MovieSearchView: AnyObject {
    var presenter: MovieSearchPresenterInterface? { get set }
    
    func updateUI(_ items: [Movie])
    func showError(message: String)
}

protocol MovieRouterInterface {
    func routeDetail(movie: Movie)
    func routeToFavourite()
}
