//
//  FavMoviesViewController.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 10/2/22.
//

import Foundation
import UIKit

class FavMoviesViewController: UIViewController{
    let resultCellIdentifier = "kCollectionCell"
    var favMoviesViewModel: FavMoviesViewModel!
    
    @IBOutlet weak var favMoviesCollectionView: MovieCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favMoviesViewModel = FavMoviesViewModel(userDefaultsWorker: UserDefaultsWorker())

        let result = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        favMoviesCollectionView.register(result, forCellWithReuseIdentifier: resultCellIdentifier)
        callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate() {
        self.favMoviesViewModel.bindFavMoviesViewModelToController = {
            DispatchQueue.main.async {
               // self.favMoviesCollectionView.moviesData = self.favMoviesViewModel.movies
                self.favMoviesCollectionView.reloadData()
            }
        }
    }
}
