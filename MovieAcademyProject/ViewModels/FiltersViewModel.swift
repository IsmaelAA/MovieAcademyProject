//
//  FiltersViewModel.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 24/2/22.
//

import Foundation

protocol FiltersViewModelProtocol {
    func callFuncGetMoviesAndAggregations(title: String, genres: [String]?, types: [String]?, years: [String]?)
    var bindFiltersViewModelToController: (() -> Void) { get set }
    var titleToSearch: String { get set }
    var aggregations: Aggregation { get set }
    var selectedAggregations: SelectedAggregation { get set }
}

class FiltersViewModel: FiltersViewModelProtocol {
    var titleToSearch: String
    var selectedAggregations: SelectedAggregation
    private var apiService: APIServiceProtocol!
    private var homeViewModel: HomeViewModelProtocol!

    var bindFiltersViewModelToController: (() -> Void) = { }
    var aggregations = Aggregation.init() {
        didSet {
            self.bindFiltersViewModelToController()
        }
    }

    init(homeViewModel: HomeViewModelProtocol, titleToSearch: String, apiService: APIServiceProtocol) {
        self.homeViewModel = homeViewModel
        self.apiService = apiService
        self.aggregations = homeViewModel.aggregations
        self.selectedAggregations = SelectedAggregation.init()
        self.titleToSearch = titleToSearch
    }

    func callFuncGetMoviesAndAggregations(title: String, genres: [String]?, types: [String]?, years: [String]?) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        homeViewModel.callFuncGetMoviesByTitle(title: titleToSearch, genres: selectedAggregations.genres, types: selectedAggregations.types, years: selectedAggregations.ranges, dispatchGroup: dispatchGroup)
        dispatchGroup.notify(queue: .main, execute: {
            self.aggregations = self.homeViewModel.aggregations
        })



    }
}
