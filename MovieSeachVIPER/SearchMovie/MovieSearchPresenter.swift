//
//  MovieSearchPresenter.swift
//  MovieSearchVIPER
//
//  Created by Suryakant Sharma on 20/08/22.
//

import UIKit

class MovieSearchPresenter: MovieSearchPresenterInterface {
    
    let interactor: MovieInteractorInterface
    let router: MovieRouterInterface
    
    weak var view: MovieSearchView?

    internal init(interactor: MovieInteractorInterface, router: MovieSearchRouter, view: MovieSearchView? = nil) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
    
    func fetchItems(searchText: String) {
        interactor.fetchItems(searchText: searchText) { [weak self] result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self?.view?.updateUI(items)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.view?.showError(message: error.localizedDescription)
                }
            }
        }
    }
    
    func fetchImage(for url: URL, callback: @escaping (Result<(UIImage, URL), Error>) -> Void) {
        interactor.fetchImage(for: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    callback(.success((image, url)))
                case .failure(let error):
                    callback(.failure(error))
                }
            }
        }
    }
    
    
    func cellTapped(at movie: Movie) {
        router.routeDetail(movie: movie)
    }
    
    func favouriteButtonTapped() {
        router.routeToFavourite()
    }
}
