//
//  ViewController.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 9/2/22.
//

import UIKit


class HomeViewController: UIViewController {

    @IBOutlet var homeSearchBar: MovieSearchBar!
    @IBOutlet weak var movieCollectionView: MovieCollectionView!
    @IBOutlet weak var filtersButton: UIButton!
    let resultCellIdentifier = "kCollectionCell"

    var homeViewModel: HomeViewModel!
    var filtersViewModel: FiltersViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        homeSearchBar.viewController = self
        movieCollectionView.viewController = self
        homeViewModel = HomeViewModel(apiService: APIService())
        // Default empty query
        homeViewModel.callFuncGetMoviesByTitle(title: "a")
        
        let result = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        movieCollectionView.register(result, forCellWithReuseIdentifier: resultCellIdentifier)
        callToViewModelForUIUpdate()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.callToViewModelForUIUpdate()
    }

    func callToViewModelForUIUpdate() {
        self.homeViewModel.bindHomeViewModelToController = {
            DispatchQueue.main.async {
                self.movieCollectionView.moviesData = self.homeViewModel.movies
                self.movieCollectionView.reloadData()
            }
        }
    }

    @IBAction func openFiltersView(_ sender: Any) {
        performSegue(withIdentifier: "showFiltersView", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showMovieDetail") {
            guard let firstVC = segue.destination as? MovieDetailViewController else { return }
            firstVC.movie = movieCollectionView.selectedMovie
        } else {
            guard let firstVC = segue.destination as? FiltersViewController else { return }
            if(self.homeSearchBar.text!.isEmpty) {
                firstVC.filtersViewModel = FiltersViewModel(homeViewModel: homeViewModel, titleToSearch: "a", apiService: APIService())
            } else {
                firstVC.filtersViewModel = FiltersViewModel(homeViewModel: homeViewModel, titleToSearch: self.homeSearchBar.text!, apiService: APIService())
            }
        }
    }
}
