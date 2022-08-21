//
//  MovieSearchBuilder.swift
//  MovieSeachVIPER
//
//  Created by Suryakant Sharma on 20/08/22.
//

import Foundation
import UIKit

struct MovieSearchBuilder {
    
    func view() -> UIViewController {
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewController = main.instantiateViewController(withIdentifier: String(describing: MovieSearchViewController.self)) as? MovieSearchViewController else {
            return UIViewController()
        }
        
        let interactor = MovieSearchInteractor()
        let router = MovieSearchRouter()
        
        let presenter = MovieSearchPresenter(
            interactor: interactor,
            router: router)
        
        viewController.presenter = presenter
        presenter.view = viewController
        
        interactor.presenter = presenter
        
        router.viewController = viewController
        return viewController
    }
}
