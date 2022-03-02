//
//  MovieCollectionView.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 10/2/22.
//

import Foundation
import UIKit

class MovieCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {

    var moviesData: [MovieWithURL]
    var selectedMovie: MovieWithURL?

    var viewController: UIViewController!
    let reusableIdentifier = "kCollectionCell"

    required init?(coder aDecoder: NSCoder) {
        self.moviesData = [MovieWithURL]()
        super.init(coder: aDecoder)
        self.dataSource = self
        self.delegate = self
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as! MovieCollectionCell
        cell.loadMovie(movieInCell: moviesData[indexPath.item])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MovieCollectionCell
        selectedMovie = cell.movieInCell
        viewController.performSegue(withIdentifier: "showMovieDetail", sender: nil)
    }
}
