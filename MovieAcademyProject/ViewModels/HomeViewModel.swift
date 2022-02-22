//
//  HomeViewModel.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 10/2/22.
//

import Foundation

protocol HomeViewModelProtocol {
    func callFuncGetMoviesByTitle(title: String, genre: String, type: String, year: String)
    var bindHomeViewModelToController: (() -> Void) { get set }
    var movies: [MovieWithURL] { get }
}

class HomeViewModel: HomeViewModelProtocol {

    private var apiService: APIServiceProtocol!

    var bindHomeViewModelToController: (() -> Void) = { }
    private(set) var movies = [MovieWithURL]() {
        didSet {
            self.bindHomeViewModelToController()
        }
    }

    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
        self.movies = [MovieWithURL]()
    }

    func callFuncGetMoviesByTitle(title: String, genre: String, type: String, year: String) {
        self.apiService.getMoviesByTitle(title: title, genre: genre, type: type, year: year) { results in
            self.movies = [MovieWithURL]()
            for movie in results.items {
                self.movies.append(MovieWithURL(movie: movie))
            }
            for i in 0...self.movies.count - 1 {
                self.apiService.getMovieImageURL(movieToLoad: self.movies[i]) { movieWithURL in
                    self.movies[i].movieURL = movieWithURL.movieURL
                } onError: { error in
                    print("Something was wrong at callFuncGetMoviesByTitle at getMovieImageURL.")
                }
            }
        } onError: { error in
            print("Something was wrong at callFuncGetMoviesByTitle.")
        }
    }
}
