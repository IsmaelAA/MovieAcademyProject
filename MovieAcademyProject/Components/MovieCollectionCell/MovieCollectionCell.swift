//
//  MovieCollectionCell.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 10/2/22.
//

import Foundation
import UIKit

class MovieCollectionCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var favButton: FavButton!

    var movieInCell: MovieWithURL!

    func loadMovie() {
        movieLabel.text = movieInCell.movie.primaryTitle

        DispatchQueue.main.async {
            guard let movieURL = self.movieInCell.movieURL else {
                self.movieImage.image = UIImage.init(systemName: "film")
                return
            }
            if let imageData: NSData = NSData(contentsOf: NSURL(string: movieURL)! as URL) {
                self.movieImage.image = UIImage(data: imageData as Data)
            }
        }
    }
}
