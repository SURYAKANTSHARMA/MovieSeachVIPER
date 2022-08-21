//
//  MovieSearchInteractor.swift
//  MovieSeachVIPER
//
//  Created by Suryakant Sharma on 20/08/22.
//
import Foundation
import class UIKit.UIImage

class MovieSearchInteractor: MovieInteractorInterface {
    
    weak var presenter: MovieSearchPresenterInterface?
    
    private let apiKey = "eeefc96f"
    
    private lazy var url: URL = {
        guard let url = URL(string: "http://www.omdbapi.com/?apikey=\(apiKey)") else {
            fatalError("URL cannot be configured")
        }
        return url
    }()
    
    func fetchItems(searchText: String,
                    callback: @escaping (Result<[Movie], Error>) -> Void) {
        
        URLSession.shared
            .dataTask(with: getURL(for: searchText)) {
                data, response, error in
            if let error = error {
                callback(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(SearchResult.self, from: data)
                    callback(.success(result.movies ?? []))
                } catch {
                    callback(.failure(error))
                }
            }
        }.resume()
    }
    
    func fetchImage(for url: URL, callback: @escaping (Result<UIImage, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                callback(.failure(error))
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                   callback(.success(image))
                } else {
                   callback(.failure("Cannot able to convert data into image"))
            }
        }.resume()
    }
    
    private func getURL(for searchText: String) -> URL {
        guard let url = url.appending(
            [URLQueryItem(name: "s",
                          value: searchText)]) else {
            fatalError("URL is not acceptable \(searchText)")
        }
        return url
    }
}

extension String: Error {}

extension URL {
    func appending(_ queryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            // URL is not conforming to RFC 3986 (maybe it is only conforming to RFC 1808, RFC 1738, and RFC 2732)
            return nil
        }
        // append the query items to the existing ones
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems

        // return the url from new url components
        return urlComponents.url
    }
}
