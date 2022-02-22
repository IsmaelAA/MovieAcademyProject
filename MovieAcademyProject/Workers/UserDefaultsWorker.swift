//
//  UserDefaultsWorker.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 15/2/22.
//

import Foundation

protocol UserDefaultsWorkerProtocol {
    func saveFavMovie(_ movieToSave: MovieWithURL)
    func loadFavMovies() -> [MovieWithURL]
    func isFavourite(_ movie: MovieWithURL) -> Bool
    func removeFavMovie(_ movieToRemove: MovieWithURL)
}

class UserDefaultsWorker: UserDefaultsWorkerProtocol {

    let favMoviesKey = "favMoviesKey"

    func saveFavMovie(_ movieToSave: MovieWithURL) {
        let data = try? JSONEncoder().encode(movieToSave)
        let defaults = UserDefaults.standard
        defaults.set(data, forKey: movieToSave.movie.tConst!)
    }

    func loadFavMovies() -> [MovieWithURL] {
        let defaults = UserDefaults.standard
        var movies = [MovieWithURL]()

        for key in defaults.dictionaryRepresentation().keys {
            let encodedData = defaults.data(forKey: key)
            if(encodedData != nil) {
                try! movies.append(JSONDecoder().decode(MovieWithURL.self, from: encodedData!)) }
        }
        return movies
    }

    func removeFavMovie(_ movieToRemove: MovieWithURL) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: movieToRemove.movie.tConst!)
    }

    func isFavourite(_ movie: MovieWithURL) -> Bool {
        let defaults = UserDefaults.standard
        guard defaults.data(forKey: movie.movie.tConst!) != nil else {
            return false
        }
        return true
    }
}
