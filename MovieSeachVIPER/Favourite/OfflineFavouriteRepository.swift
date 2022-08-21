//
//  OfflineFavouriteRepository.swift
//  MovieSeachVIPER
//
//  Created by Suryakant Sharma on 21/08/22.
//

import Foundation

protocol OfflineFavouriteRepositoryInterface {
    func fetchFavourite() throws -> [Movie]
    func save(_ value: [Movie]) throws
}

class OfflineFavouriteRepository: OfflineFavouriteRepositoryInterface {
    private let key = "favourites"
    private let disk = DiskStorage(path: getDocumentsDirectory())
    lazy var storage: CodableStorage = {
        CodableStorage(storage: disk)
    }()

    
    func fetchFavourite() throws -> [Movie] {
        try storage.fetch(for: key)
    }
    
    func save(_ value: [Movie]) throws {
        try storage.save(value, for: key)
    }
}

// MARK:- Helpers

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
}
