//
//  MovieRequest.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 23/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//

import Foundation

class MoviesRequester {
    
    let API_KEY: String = "1f54bd990f1cdfb230adb312546d765d"
    var genres: [GenreWrapper] = []
    
    func makeMovieRequest(page: Int = 1, completion: ((Result<ResultsPage>) -> Void)?) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = "/3/movie/upcoming"
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                guard responseError == nil else {
                    completion?(.failure(responseError!))
                    return
                }
                
                guard let jsonData = responseData else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    completion?(.failure(error))
                    return
                }
                
                let decoder = JSONDecoder()
                
                do {
                    let pages = try decoder.decode(ResultsPage.self, from: jsonData)
                    completion?(.success(pages))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    func makeFirstPageRequest(page: Int = 1, completion: ((Result<ResultsPage>) -> Void)?) {
        
        makeGenresRequest { (result) in
            switch result {
            case .success(let resultsGenre):
                self.genres = resultsGenre.genres
                self.makeMovieRequest(completion: completion)
                
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
        }
        
    }
    
    
    func makeGenresRequest(completion: ((Result<ResultsGenre>) -> Void)?) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = "/3/genre/movie/list"
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY),
            URLQueryItem(name: "language", value: "en-US")
        ]
        
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                guard responseError == nil else {
                    completion?(.failure(responseError!))
                    return
                }
                
                guard let jsonData = responseData else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    completion?(.failure(error))
                    return
                }
                
                let decoder = JSONDecoder()
                
                do {
                    let pages = try decoder.decode(ResultsGenre.self, from: jsonData)
                    completion?(.success(pages))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
        
        task.resume()

    }
    
}

enum Result<Value> {
    
    case success(Value)
    case failure(Error)
}
