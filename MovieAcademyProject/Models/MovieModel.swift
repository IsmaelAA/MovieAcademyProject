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
    var aggregations: Aggregation
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
    var types: [String: Int]?
    var ranges: [String: Int]?
    var genres: [String: Int]?

    init() {
        self.types = [String: Int]()
        self.ranges = [String: Int]()
        self.genres = [String: Int]()
    }
}

struct AggregationArray {
    var types: [String]
    var ranges: [String]
    var genres: [String]

    init() {
        self.types = [String]()
        self.ranges = [String]()
        self.genres = [String]()
    }
}

struct Suggestion: Codable, Equatable {
    let score: Double
    let text: String
}
