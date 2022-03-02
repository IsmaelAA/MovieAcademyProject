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
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieRuntimeMinutes: UILabel!

    var movie: MovieWithURL!

    override func viewDidLoad() {
        loadMovieData()
    }

    func loadMovieData() {
        movieTitle.text = movie.movie.primaryTitle
        self.movieImage.image = UIImage(systemName: "arrow.triangle.2.circlepath")

        if let startYear = movie.movie.startYear {
            movieTitle.text?.append("(\(startYear))")
        }

        if let runtimeMinutes = movie.movie.runtimeMinutes {
            movieRuntimeMinutes.text = "Runtime Minutes: \(runtimeMinutes)"
        } else {
            movieRuntimeMinutes.text = "Runtime Minutes: Unspecified"
        }

        if let averageRating = movie.movie.averageRating {
            movieRating.text = "Average Rating: \(averageRating)"
            if let numOfVotes = movie.movie.numVotes {
                movieRating.text?.append(" based on \(numOfVotes) votes")
            }
        } else {
            movieRating.text = "Average Rating: Unspecified"
        }

        if let genres = movie.movie.genres {
            movieGenres.text = "\(genres.description.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: "\"", with: ""))"
        } else {
            movieGenres.text = "Unspecified genre"
        }

        if(movie.movieURL != nil) {
            let identifier = movie.movieURL
            if let url = movie.movieURL {
                let getDataTask = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in guard let data = data, error == nil else {
                    return }
                    if(self.movie.movieURL == identifier) {
                        DispatchQueue.main.async {
                            self.movieImage.image = UIImage(data: data)
                            self.movieImage.contentMode = .scaleAspectFill
                        }
                    }
                }
                getDataTask.resume()
            } } else {
            self.movieImage.image = UIImage(systemName: "film")
        }
    }
}
