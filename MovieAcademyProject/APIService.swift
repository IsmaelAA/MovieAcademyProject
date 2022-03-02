//
//  APIService.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 15/2/22.
//

import Foundation

protocol APIServiceProtocol {
    func getMoviesByTitle(title: String, genres: [String]?, types: [String]?, ranges: [String]?, onSuccess: @escaping (Results) -> Void, onError: ((_ error: Error?) -> Void)?)
    func getMovieImageURL(movieToLoad: MovieWithURL, onSuccess: @escaping (MovieWithURL) -> Void, onError: ((_ error: Error?) -> Void)?)
}

class APIService: APIServiceProtocol {

    var task: URLSessionDataTask?
    var taskImageLoad: URLSessionDataTask?
    var numberOfResults = 20

    func getMoviesByTitle(title: String, genres: [String]?, types: [String]?, ranges: [String]?, onSuccess: @escaping (Results) -> Void, onError: ((_ error: Error?) -> Void)?) {
        task?.cancel()
        var urlComponents = URLComponents(string: "http://localhost:8080/search")

        urlComponents?.queryItems = [URLQueryItem.init(name: "query", value: title)]
        urlComponents?.queryItems?.append(contentsOf: getOptionalQueryItems(genres: genres, types: types, ranges: ranges))
        urlComponents?.queryItems?.append(URLQueryItem.init(name: "rows", value: "\(numberOfResults)"))

        guard let url = urlComponents?.url else { fatalError("Could not create URL from components") }
        print(url)
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

    func getOptionalQueryItems(genres: [String]?, types: [String]?, ranges: [String]?) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()

        if genres != nil && !genres!.isEmpty {
            queryItems.append(URLQueryItem.init(name: "genre", value: genres!.description.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\"", with: "")))
        }

        if types != nil && !types!.isEmpty {
            queryItems.append(URLQueryItem.init(name: "type", value: types!.description.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\"", with: "")))
        }

        if ranges != nil && !ranges!.isEmpty {
            queryItems.append(URLQueryItem.init(name: "year", value: ranges!.description.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\"", with: "")))
        }

        return queryItems
    }

// API KEY SHOULD BE REMOVED FROM HERE IN THE FUTURE
//https://api.themoviedb.org/3/movie/550?api_key=728cc58559e77ec7290c8798731010de
    func getMovieImageURL(movieToLoad: MovieWithURL, onSuccess: @escaping (MovieWithURL) -> Void, onError: ((_ error: Error?) -> Void)?) {
        let urlString = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=728cc58559e77ec7290c8798731010de&language=en-US&query=" + (movieToLoad.movie.primaryTitle?.replacingOccurrences(of: " ", with: "%20") ?? "a") + "&page=1&include_adult=false")

        guard let url = urlString else {
            onSuccess(movieToLoad)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        taskImageLoad = URLSession.shared.dataTask(with: request) { data, response, error in
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
                    guard let posterPath = resultDTO.results[0].poster_path else { onSuccess(movieToLoad); return }
                    onSuccess(MovieWithURL.init(movie: movieToLoad.movie, movieURL: "https://image.tmdb.org/t/p/original" + posterPath)) }
                else {
                    onSuccess(movieToLoad)
                }
            } catch {
                onError?(error)
            }
        }
        taskImageLoad?.resume()
    }
}
