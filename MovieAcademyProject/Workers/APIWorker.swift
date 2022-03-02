//
//  APIWorker.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 1/3/22.
//

import Foundation

class APIWorker {
    var apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
}
