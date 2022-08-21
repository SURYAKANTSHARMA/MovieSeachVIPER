//
//  MovieSearchRouter.swift
//  MovieSearchVIPER
//
//  Created by Suryakant Sharma on 20/08/22.
//

import UIKit

class MovieSearchRouter: MovieRouterInterface {
    
    weak var viewController: UIViewController?
    
    func routeDetail(movie: Movie) {
        let detailVC = MovieDetailBuilder().view(movie: movie)
        viewController?.showDetailViewController(detailVC, sender: nil)
    }
    
    func routeToFavourite() {
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        guard let favouriteVC = main.instantiateViewController(withIdentifier: String(describing: FavouriteTableViewController.self)) as? FavouriteTableViewController else {
            return
        }
        favouriteVC.respository = OfflineFavouriteRepository()
        viewController?.navigationController?.show(favouriteVC, sender: nil)
    }
}
