//
//  FavMoviesViewModel.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 10/2/22.
//

import Foundation

protocol FavMoviesViewModelProtocol {
    var bindFavMoviesViewModelToController: (() -> Void) { get set }
    var movies: [MovieWithURL] { get }
    func callUserDefaultsLoadFavMovies()
}

class FavMoviesViewModel: FavMoviesViewModelProtocol {
    private var defaultsWorker: UserDefaultsWorkerProtocol
    
    var bindFavMoviesViewModelToController: (() -> Void) = { }
    private(set) var movies = [MovieWithURL]() {
        didSet {
            self.bindFavMoviesViewModelToController()
        }
    }

    init(userDefaultsWorker: UserDefaultsWorker) {
        self.defaultsWorker = userDefaultsWorker
        self.movies = [MovieWithURL]()
    }

    func callUserDefaultsLoadFavMovies() {
        DispatchQueue.main.async {
            self.movies = self.defaultsWorker.loadFavMovies().sorted{
                $0.movie.primaryTitle ?? "a" < $1.movie.primaryTitle ?? "b"
            }
        }
    }
}
