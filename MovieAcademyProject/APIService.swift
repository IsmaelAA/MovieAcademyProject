//
//  APIService.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 15/2/22.
//

import Foundation

protocol APIServiceProtocol {
    func getMoviesByTitle(title: String, genre: String, type: String, year: String, onSuccess: @escaping (Results) -> Void, onError: ((_ error: Error?) -> Void)?)
}

class APIService: APIServiceProtocol {


    var task: URLSessionDataTask?

    func getMoviesByTitle(title: String, genre: String, type: String, year: String, onSuccess: @escaping (Results) -> Void, onError: ((_ error: Error?) -> Void)?) {
        task?.cancel()
        var urlComponents = URLComponents()

        // localhost:8080/search?query=spiderman&genre=Action&type=Movie,tvEpisode&year=2000/2001,2008/2015"

        urlComponents.scheme = "https"
        urlComponents.host = "localhost:8080"
        urlComponents.path = "/search"
        urlComponents.queryItems = [URLQueryItem.init(name: "query", value: "spiderman"), URLQueryItem.init(name: "genre", value: "Action"), URLQueryItem.init(name: "type", value: "Movie"), URLQueryItem.init(name: "year", value: "2000/2001")]

        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else { // check for fundamental networking error
                print("error", error ?? "Unknown error")
                onError?(error)
                return
            }

            guard (200 ... 299) ~= response.statusCode else { // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                onError?(nil)
                return
            }

            let decoder = JSONDecoder()

            do {
                let resultDTO = try decoder.decode(Results.self, from: data)
                onSuccess(resultDTO)
            } catch {
                onError?(error)
            }
        }

        task?.resume()
    }

}
