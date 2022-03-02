//
//  HomeViewModel.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 10/2/22.
//

import Foundation

protocol HomeViewModelProtocol {
    func callFuncGetMoviesByTitle(title: String, genres: [String]?, types: [String]?, ranges: [String]?, dispatchGroup: DispatchGroup?)
    var bindHomeViewModelToController: (() -> Void) { get set }
    var movies: [MovieWithURL] { get }
    var aggregations: Aggregation { get set }
    var selectedAggregations: AggregationArray { get set }
}

class HomeViewModel: HomeViewModelProtocol {
    var aggregations: Aggregation
    var selectedAggregations: AggregationArray
    private var apiService: APIServiceProtocol

    var bindHomeViewModelToController: (() -> Void) = { }
   
    private(set) var movies = [MovieWithURL]() {
        didSet {
            self.bindHomeViewModelToController()
        }
    }

    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
        self.movies = [MovieWithURL]()
        self.aggregations = Aggregation.init()
        self.selectedAggregations = AggregationArray.init()
    }

    func callFuncGetMoviesByTitle(title: String, genres: [String]? = nil, types: [String]? = nil, ranges: [String]? = nil, dispatchGroup: DispatchGroup? = nil) {
        self.apiService.getMoviesByTitle(title: title, genres: genres, types: types, ranges: ranges) { results in
            self.movies = [MovieWithURL]()

            for movie in results.items {
                self.movies.append(MovieWithURL(movie: movie))
            }

            self.aggregations = results.aggregations
            
            let moviesNumber = self.movies.count
            if(moviesNumber > 0) {
                for i in 0...moviesNumber - 1 {
                    self.apiService.getMovieImageURL(movieToLoad: self.movies[i]) { movieWithURL in
                        if(moviesNumber == self.movies.count) {
                            self.movies[i].movieURL = movieWithURL.movieURL
                        }
                    } onError: { error in
                        print("Something was wrong at callFuncGetMoviesByTitle at getMovieImageURL.")
                    }
                }
                if(dispatchGroup != nil) {
                    dispatchGroup?.leave()
                }
            }
        } onError: { error in
            print("Something was wrong at callFuncGetMoviesByTitle.")
        }
    }
}
