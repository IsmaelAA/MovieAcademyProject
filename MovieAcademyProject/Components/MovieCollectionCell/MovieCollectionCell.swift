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
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var favButton: UIButton!

    var userDefaultsWorker = UserDefaultsWorker()
    var movieInCell: MovieWithURL!
    var favButPressed = false

    func loadMovie(movieInCell: MovieWithURL) {
        self.movieInCell = movieInCell

        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = layer.frame.height * 0.05
        clipsToBounds = true

        movieLabel.text = " \(movieInCell.movie.primaryTitle!)"
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "star.square.fill")
        let attachmentStr = NSAttributedString(attachment: attachment)
        let ratingString = NSMutableAttributedString(string: " \(movieInCell.movie.averageRating!) ")
        ratingString.append(attachmentStr)
        movieRating.attributedText = ratingString

        movieImage.image = UIImage.init(systemName: "film")
        movieImage.contentMode = .scaleAspectFit
        if(self.userDefaultsWorker.isFavourite(self.movieInCell)) {
            self.favButPressed = true
            self.favButton.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            self.favButPressed = false
            self.favButton.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        }

        if(movieInCell.movieURL != nil) {
            let identifier = movieInCell.movieURL

            let getDataTask = URLSession.shared.dataTask(with: URL(string: movieInCell.movieURL!)!) { data, _, error in guard let data = data, error == nil else {
                return }
                if(self.movieInCell.movieURL == identifier) {
                    DispatchQueue.main.async {
                        self.movieImage.image = UIImage(data: data)
                        self.movieImage.contentMode = .scaleAspectFill
                    }
                }
            }
            getDataTask.resume()
        }
    }

    @IBAction func touchFavButton(_ sender: Any) {
        favButPressed = !favButPressed

        if(favButPressed) {
            userDefaultsWorker.saveFavMovie(movieInCell)
            favButton.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            userDefaultsWorker.removeFavMovie(movieInCell)
            favButton.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        }
    }


}
