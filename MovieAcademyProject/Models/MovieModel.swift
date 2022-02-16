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
    let aggregations: String
    let suggestions: Suggestion
}

struct Movie: Codable, Equatable {
    let primartyTitle: String
    let titleType: String
    let score: Double
    let originalTitle: String
    let genres: [String]
    let averagrRating: Double
    let startYear: Int
    let tConst: String
    let numVotes: Int
    let isAdult: Bool
}

struct Aggregation: Codable, Equatable {
    let types: MType
    let ranges: MRange
    let genres: MGenre
}

struct MType: Codable, Equatable {
    let movie: Int
    let tvEpisode: Int
}

struct MRange: Codable, Equatable {

}

struct MGenre: Codable, Equatable {
    let Action: Int
}

struct Suggestion: Codable, Equatable {
    let score: Double
    let text: String
}
