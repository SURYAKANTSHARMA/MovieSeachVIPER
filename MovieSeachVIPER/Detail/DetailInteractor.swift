//
//  DetailInteractor.swift
//  MovieSeachVIPER
//
//  Created by Suryakant Sharma on 20/08/22.
//

import Foundation

class DetailInteractor: MovieDetailInteractorInterface {
    
    private let apiKey = "eeefc96f"
    private let session = URLSession.shared
    private lazy var url: URL = {
        guard let url = URL(string: "http://www.omdbapi.com/?apikey=\(apiKey)") else {
            fatalError("URL cannot be configured")
        }
        return url
    }()

    var presenter: MovieDetailPresenterInterface?
    
    func fetchDetails(imbdId: String,
                      callback: @escaping (Result<MovieDetail, Error>) -> Void) {
        
        session.dataTask(with: getURL(for : imbdId)) {
            data, response, error in
            if let error = error {
                callback(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(MovieDetail.self, from: data)
                    callback(.success(result))
                } catch {
                    callback(.failure(error))
                }
            }
        }.resume()
    }

    
    
    func getURL(for imbdId: String) -> URL {
        guard let url = url.appending(
            [URLQueryItem(name: "i",
                          value: imbdId),
             URLQueryItem(name: "plot",
                           value: "full")
            ]) else {
            fatalError("URL is not acceptable \(imbdId)")
        }
        return url
    }
}
