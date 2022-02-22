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

    let resultCellIdentifier = "kCollectionCell"

    var homeViewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        homeSearchBar.viewController = self
        homeViewModel = HomeViewModel(apiService: APIService())
        // Default empty query
        homeViewModel.callFuncGetMoviesByTitle(title: "a", genre: "", type: "", year: "")

        let result = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        movieCollectionView.register(result, forCellWithReuseIdentifier: resultCellIdentifier)
        callToViewModelForUIUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        homeViewModel.callFuncGetMoviesByTitle(title: "a", genre: "", type: "", year: "")
        callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate() {
        self.homeViewModel.bindHomeViewModelToController = {
            DispatchQueue.main.async {
                self.movieCollectionView.moviesData = self.homeViewModel.movies
                self.movieCollectionView.reloadData()
            }
        }
    }
}
