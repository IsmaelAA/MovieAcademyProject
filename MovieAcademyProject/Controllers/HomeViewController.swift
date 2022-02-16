//
//  ViewController.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 9/2/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeSearchBar: UISearchBar!
    @IBOutlet weak var movieCollectionView: MovieCollectionView!

    let resultCellIdentifier = "kCollectionCell"

    var homeViewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        homeViewModel = HomeViewModel(apiService: APIService())

        homeViewModel.callFuncGetMoviesByTitle(title: "String", genre: "String", type: "String", year: "String")
        
        let result = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        movieCollectionView.register(result, forCellWithReuseIdentifier: resultCellIdentifier)
    }

    func callToViewModelForUIUpdate() {
        self.homeViewModel.bindHomeViewModelToController = {
            DispatchQueue.main.async {
                self.movieCollectionView.reloadData()
            }
        }
    }

}

