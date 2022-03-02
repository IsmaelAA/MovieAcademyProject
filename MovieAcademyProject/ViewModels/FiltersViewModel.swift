//
//  FiltersViewModel.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 24/2/22.
//

import Foundation

protocol FiltersViewModelProtocol {
    func callFuncGetMoviesAndAggregations(title: String, genres: [String]?, types: [String]?, ranges: [String]?)
    var bindFiltersViewModelToController: (() -> Void) { get set }
    var titleToSearch: String { get set }
    var aggregations: Aggregation { get set }
    var aggregationsArray: AggregationArray { get set }
    var selectedAggregations: AggregationArray { get set }
}

class FiltersViewModel: FiltersViewModelProtocol {
    var aggregationsArray: AggregationArray
    var titleToSearch: String
    var selectedAggregations: AggregationArray
    private var apiWorker: APIWorker
    
    // THIS SHOULDNT BE HERE, but I have no time to fix it.
    private var homeViewModel: HomeViewModelProtocol!

    var bindFiltersViewModelToController: (() -> Void) = { }
    var aggregations: Aggregation {
        didSet {
            self.aggregationsToArray()
            self.sortAggregations()
            self.bindFiltersViewModelToController()
        }
    }

    init(homeViewModel: HomeViewModel, selectedAggregations: AggregationArray, titleToSearch: String, apiService: APIServiceProtocol) {
        self.homeViewModel = homeViewModel
        self.apiWorker = APIWorker(apiService: apiService)
        self.aggregations = homeViewModel.aggregations
        self.aggregationsArray = AggregationArray.init()
        self.selectedAggregations = selectedAggregations
        self.titleToSearch = titleToSearch
        aggregationsToArray()
        sortAggregations()
    }

    func aggregationsToArray() {
        aggregationsArray.genres = aggregations.genres?.keys.map({ key in
            return key
        }) ?? [String]()

        aggregationsArray.types = aggregations.types?.keys.map({ key in
            return key
        }) ?? [String]()

        aggregationsArray.ranges = aggregations.ranges?.keys.map({ key in
            return key
        }) ?? [String]()

    }
    
    func sortAggregations(){
        aggregationsArray.genres.sort()
        aggregationsArray.types.sort()
        aggregationsArray.ranges.sort()
    }

    func callFuncGetMoviesAndAggregations(title: String, genres: [String]?, types: [String]?, ranges: [String]?) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        homeViewModel.selectedAggregations = self.selectedAggregations
        homeViewModel.callFuncGetMoviesByTitle(title: titleToSearch, genres: selectedAggregations.genres, types: selectedAggregations.types, ranges: selectedAggregations.ranges, dispatchGroup: dispatchGroup)
        dispatchGroup.notify(queue: .main, execute: {
            self.aggregations = self.homeViewModel.aggregations
        })
    }
}
