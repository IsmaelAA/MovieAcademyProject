//
//  FavMoviesViewController.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 10/2/22.
//

import Foundation
import UIKit

class FavMoviesViewController: UIViewController {
    @IBOutlet weak var favMoviesCollectionView: MovieCollectionView!
    
    let resultCellIdentifier = "kCollectionCell"
    var favMoviesViewModel: FavMoviesViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        favMoviesCollectionView.viewController = self
        favMoviesViewModel = FavMoviesViewModel(userDefaultsWorker: UserDefaultsWorker())
        favMoviesViewModel.callUserDefaultsLoadFavMovies()

        let result = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        favMoviesCollectionView.register(result, forCellWithReuseIdentifier: resultCellIdentifier)
        callToViewModelForUIUpdate()
    }

    override func viewWillAppear(_ animated: Bool) {
        reloadView()
    }

    func reloadView() {
        favMoviesViewModel.callUserDefaultsLoadFavMovies()
        callToViewModelForUIUpdate()
    }

    func callToViewModelForUIUpdate() {
        self.favMoviesViewModel.bindFavMoviesViewModelToController = {
            DispatchQueue.main.async {
                self.favMoviesCollectionView.moviesData = self.favMoviesViewModel.movies
                self.favMoviesCollectionView.reloadData()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let firstVC = segue.destination as? MovieDetailViewController else { return }
        firstVC.movie = favMoviesCollectionView.selectedMovie
    }
}
