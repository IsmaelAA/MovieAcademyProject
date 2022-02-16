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
    var movies: [Movie] { get }
}

class HomeViewModel: HomeViewModelProtocol {

    private var apiService: APIServiceProtocol!

    var bindHomeViewModelToController: (() -> Void) = { }
    private(set) var movies = [Movie]() {
        didSet {
            self.bindHomeViewModelToController()
        }
    }


    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
        self.movies = [Movie]()
    }

    func callFuncGetMoviesByTitle(title: String, genre: String, type: String, year: String) {
        self.apiService.getMoviesByTitle(title: title, genre: genre, type: type, year: year) { results in
            self.movies = results.items
        } onError: { error in
            print("Something was wrong :D")
        }
    }

}
