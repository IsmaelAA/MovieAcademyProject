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
        homeViewModel.callFuncGetMoviesByTitle(title: "a", genre: "", type: "", year: "")

        let result = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        movieCollectionView.register(result, forCellWithReuseIdentifier: resultCellIdentifier)
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

//extension HomeViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        homeViewModel.callFuncGetMoviesByTitle(title: searchText, genre: "", type: "", year: "")
//        callToViewModelForUIUpdate()
//    }
//}
