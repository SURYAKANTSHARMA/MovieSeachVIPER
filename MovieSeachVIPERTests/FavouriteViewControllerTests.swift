//
//  FavouriteViewControllerTests.swift
//  FavouriteViewControllerTests
//
//  Created by Suryakant Sharma on 20/08/22.
//

import XCTest
@testable import MovieSeachVIPER

class FavouriteViewControllerTests: XCTestCase {

    func test_viewDidload_shouldTriggerFavourite_fetchFromRepository() {
        let spy = RepositorySpy()
        let sut = makeSUT(spy: spy)
        XCTAssertEqual(spy.fetchCounter, 1)
    }
}


// MARK :- Helpers
private func makeSUT(spy: OfflineFavouriteRepositoryInterface = RepositorySpy()) -> UIViewController {
    let main = UIStoryboard(name: "Main", bundle: nil)
    
    guard let favouriteVC = main.instantiateViewController(withIdentifier: String(describing: FavouriteTableViewController.self)) as? FavouriteTableViewController else {
        XCTFail("cannot intantiate vc")
        return UIViewController()
    }
    favouriteVC.respository = spy
    _ = favouriteVC.view
    return favouriteVC
}

class RepositorySpy: OfflineFavouriteRepositoryInterface {
    var fetchCounter = 0
    var movies: [Movie] = []
    
    func fetchFavourite() throws -> [Movie] {
        fetchCounter += 1
        return movies
    }
    
    func save(_ value: [Movie]) throws {
        
    }
}
