//
//  DetailPresenter.swift
//  MovieSeachVIPER
//
//  Created by Suryakant Sharma on 20/08/22.
//

import Foundation

class DetailPresenter: MovieDetailPresenterInterface {
    
    let interactor: MovieDetailInteractorInterface
    var view: MovieDetailView?
    
    init(interactor: MovieDetailInteractorInterface,
         view: MovieDetailView? = nil) {
        self.interactor = interactor
        self.view = view
    }

    func fetchDetails(imbdId: String) {
        interactor.fetchDetails(imbdId: imbdId) { [weak self] result in
            switch result {
              case .success(let movieDetail):
                DispatchQueue.main.async {
                    self?.view?.updateUI(movieDetail)
                }
              case .failure(let error):
                DispatchQueue.main.async {
                    self?.view?.showError(message: error.localizedDescription)
                }
            }
        }
    }
}
