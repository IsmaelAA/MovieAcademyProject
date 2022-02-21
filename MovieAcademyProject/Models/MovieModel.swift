//
//  MovieModel.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 10/2/22.
//

import Foundation

struct Results: Codable, Equatable {
    let total: Int
    let items: [Movie]
    let aggregations: Aggregation
    let suggestions: [Suggestion]
}

struct Movie: Codable, Equatable {
    let primaryTitle: String?
    let titleType: String?
    let score: Double?
    let originalTitle: String?
    let genres: [String]?
    let averageRating: Double?
    let runtimeMinutes: Int?
    let startYear: Int?
    let tConst: String?
    let numVotes: Int?
    let isAdult: Bool?
}

struct MovieWithURL: Codable, Equatable {
    var movie: Movie
    var movieURL: String?

    init(movie: Movie) {
        self.movie = movie
    }
    init(movie: Movie, movieURL: String) {
        self.movie = movie
        self.movieURL = movieURL
    }
}

struct ResultsTMDB: Codable, Equatable {
    let results: [PosterPath]
}

struct PosterPath: Codable, Equatable {
    var poster_path: String?
}

struct Aggregation: Codable, Equatable {
    let types: [String: Int]?
    let ranges: [String: Int]?
    let genres: [String: Int]?
}

struct Suggestion: Codable, Equatable {
    let score: Double
    let text: String
}
