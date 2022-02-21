//
//  APIService.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 15/2/22.
//

import Foundation

protocol APIServiceProtocol {
    func getMoviesByTitle(title: String, genre: String, type: String, year: String, onSuccess: @escaping (Results) -> Void, onError: ((_ error: Error?) -> Void)?)
    func getMovieImageURL(movieToLoad: MovieWithURL, onSuccess: @escaping (MovieWithURL) -> Void, onError: ((_ error: Error?) -> Void)?)
}

class APIService: APIServiceProtocol {

    var task: URLSessionDataTask?

    func getMoviesByTitle(title: String, genre: String, type: String, year: String, onSuccess: @escaping (Results) -> Void, onError: ((_ error: Error?) -> Void)?) {
        task?.cancel()
        var urlComponents = URLComponents(string: "http://localhost:8080/search")

//        "localhost:8080/search?query=spiderman&genre=Action&type=Movie,tvEpisode&year=2000/2001,2008/2015"

//        urlComponents.scheme = "https"
//        urlComponents.host = "localhost:8080"
//        urlComponents.path = "/search"

        urlComponents?.queryItems = [URLQueryItem.init(name: "query", value: title), URLQueryItem.init(name: "rows", value: "20")]
//                                     , URLQueryItem.init(name: "genre", value: genre), URLQueryItem.init(name: "type", value: type), URLQueryItem.init(name: "year", value: year)]

        guard let url = urlComponents?.url else { fatalError("Could not create URL from components") }
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

    // API KEY
    //https://api.themoviedb.org/3/movie/550?api_key=728cc58559e77ec7290c8798731010de
    func getMovieImageURL(movieToLoad: MovieWithURL, onSuccess: @escaping (MovieWithURL) -> Void, onError: ((_ error: Error?) -> Void)?) {
        let urlString = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=728cc58559e77ec7290c8798731010de&language=en-US&query=" + movieToLoad.movie.primaryTitle!.replacingOccurrences(of: " ", with: "%20") + "&page=1&include_adult=false")

        guard let url = urlString else {
            onSuccess(movieToLoad)
            return
        }

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
                let resultDTO = try decoder.decode(ResultsTMDB.self, from: data)
                if(!resultDTO.results.isEmpty) {
                    guard let posterPath = resultDTO.results[0].poster_path else { onSuccess(movieToLoad); return}
                    onSuccess(MovieWithURL.init(movie: movieToLoad.movie, movieURL: "https://image.tmdb.org/t/p/original" + posterPath)) }
                else {
                    onSuccess(movieToLoad)
                }
            } catch {
                onError?(error)
            }
        }
        task?.resume()
    }
}
