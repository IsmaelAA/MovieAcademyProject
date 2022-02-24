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

        setCustomLayer()
        
        setMovieTitle()
        setRating()
        setFavButton()
        setMovieImage()
    }

    func setCustomLayer(){
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = layer.frame.height * 0.05
        clipsToBounds = true
    }
    
    func setMovieTitle() {
        movieLabel.text = " \(movieInCell.movie.primaryTitle!)"
    }

    func setRating() {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "star.fill")
        attachment.image = attachment.image?.withTintColor(UIColor.systemYellow)
        let attachmentStr = NSAttributedString(attachment: attachment)
        let ratingString = NSMutableAttributedString(attributedString: attachmentStr)

        if let averageRating = movieInCell.movie.averageRating {
            ratingString.append(NSMutableAttributedString(string: " \(averageRating)"))
        } else {
            ratingString.append(NSMutableAttributedString(string: "Unspecified"))
        }

        movieRating.attributedText = ratingString
    }

    func setFavButton() {
        if(userDefaultsWorker.isFavourite(movieInCell)) {
            favButPressed = true
            favButton.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            favButton.tintColor = UIColor.systemBlue
        } else {
            favButPressed = false
            favButton.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
            favButton.tintColor = UIColor.darkGray
        }
    }

    func setMovieImage() {
        movieImage.image = UIImage.init(systemName: "film")
        movieImage.contentMode = .scaleAspectFit
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
        else{
            movieImage.image = UIImage.init(systemName: "film.fill")
        }
    }

    @IBAction func touchFavButton(_ sender: Any) {
        favButPressed = !favButPressed

        if(favButPressed) {
            userDefaultsWorker.saveFavMovie(movieInCell)
            favButton.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            favButton.tintColor = UIColor.systemBlue
        } else {
            userDefaultsWorker.removeFavMovie(movieInCell)
            favButton.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
            favButton.tintColor = UIColor.darkGray
        }
    }


}
