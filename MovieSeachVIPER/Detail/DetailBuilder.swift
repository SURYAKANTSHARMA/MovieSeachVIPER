//
//  DetailBuilder.swift
//  MovieSeachVIPER
//
//  Created by Suryakant Sharma on 20/08/22.
//

import UIKit

struct MovieDetailBuilder {
    
    func view(movie: Movie) -> UIViewController {
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewController = main.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController else {
            return UIViewController()
        }
        
        let interactor = DetailInteractor()
        
        let presenter = DetailPresenter(interactor: interactor,
                                        view: viewController)
        viewController.presenter = presenter
        interactor.presenter = presenter

        viewController.movie = movie
        return viewController
    }
}
