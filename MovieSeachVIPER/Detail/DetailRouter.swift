//
//  DetailRouter.swift
//  MovieSeachVIPER
//
//  Created by Suryakant Sharma on 20/08/22.
//

import UIKit



protocol MovieDetailInteractorInterface: AnyObject {
    var presenter: MovieDetailPresenterInterface? {get set}

    func fetchDetails(imbdId: String,
                    callback: @escaping (Result<MovieDetail, Error>) -> Void)
}

protocol MovieDetailPresenterInterface: AnyObject {
    func fetchDetails(imbdId: String)
}

protocol MovieDetailView: AnyObject {
    var presenter: MovieDetailPresenterInterface? { get set }
    
    func updateUI(_ detail: MovieDetail)
    func showError(message: String)
}

protocol MovieDetailRouterInterface {
    //func routeToDetail(id: Int)
}
