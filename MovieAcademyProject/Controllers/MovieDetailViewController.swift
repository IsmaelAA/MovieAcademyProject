//
//  MovieDetailViewController.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 10/2/22.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieStartYear: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieRuntimeMinutes: UILabel!

    var movie: MovieWithURL!

    override func viewDidLoad() {
        loadMovieData()
    }

    func loadMovieData() {
        movieTitle.text = movie.movie.primaryTitle
        
        if let startYear = movie.movie.startYear {
            movieStartYear.text = "\(startYear)"
        } else {
            movieStartYear.text = "Unspecified"
        }
        
        if let runtimeMinutes = movie.movie.runtimeMinutes {
            movieRuntimeMinutes.text = "Runtime Minutes: \(runtimeMinutes)"
        } else {
            movieRuntimeMinutes.text = "Runtime Minutes: Unspecified"
        }
        
        if let averageRating = movie.movie.averageRating {
            movieRating.text = "Average Rating: \(averageRating)"
        } else {
            movieRating.text = "Average Rating: Unspecified"
        }
    
        if let genres = movie.movie.genres {
            movieGenres.text = "\(genres)"
        } else {
            movieGenres.text = "Unspecified genre"
        }
        
        if(movie.movieURL != nil) {
            let identifier = movie.movieURL

            let getDataTask = URLSession.shared.dataTask(with: URL(string: movie.movieURL!)!) { data, _, error in guard let data = data, error == nil else {
                return }
                if(self.movie.movieURL == identifier) {
                    DispatchQueue.main.async {
                        self.movieImage.image = UIImage(data: data)
                        self.movieImage.contentMode = .scaleAspectFill
                    }
                }
            }
            getDataTask.resume()
        }
    }
}
