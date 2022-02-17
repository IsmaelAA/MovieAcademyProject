//
//  UserDefaultsWorker.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 15/2/22.
//

import Foundation

protocol UserDefaultsWorkerProtocol {
    func saveFavMovie(_ movieToSave: Movie)
    func loadFavMovies() -> [Movie]?
    func removeFavMovie(_ movieToRemove: Movie)
}

class UserDefaultsWorker: UserDefaultsWorkerProtocol {
    let favMoviesKey = "favMoviesKey"

    func saveFavMovie(_ movieToSave: Movie) {

    }

    func loadFavMovies() -> [Movie]? {
        return [Movie]()
    }

    func removeFavMovie(_ movieToRemove: Movie) {

    }
}
