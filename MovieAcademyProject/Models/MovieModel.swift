//
//  MovieModel.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 10/2/22.
//

import Foundation

struct Movie: Codable {
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
