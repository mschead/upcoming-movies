//
//  MovieRequest.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 23/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//

import Foundation
import Alamofire

class MoviesRequester {
    
    let API_KEY: String = "1f54bd990f1cdfb230adb312546d765d"
    var genres: [GenreWrapper] = []
    
    func makeMovieRequest(page: Int = 1, completion: ((Result<ResultsPage>) -> Void)?) {
        
        let parameters: Parameters = [
            "api_key": API_KEY,
            "language": "en-US",
            "page": String(page)
        ]
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming")
        Alamofire.request(url!, parameters: parameters).responseJSON { response in
            do {
                let pages = try JSONDecoder().decode(ResultsPage.self, from: response.data!)
                completion?(.success(pages))
            } catch {
                completion?(.failure(error))
            }
        }
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
        let parameters: Parameters = [
            "api_key": API_KEY,
            "language": "en-US"
        ]
        
        let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list")
        Alamofire.request(url!, parameters: parameters).responseJSON { response in
            do {
                let pages = try JSONDecoder().decode(ResultsGenre.self, from: response.data!)
                completion?(.success(pages))
            } catch {
                completion?(.failure(error))
            }
        }

    }
    
}

enum Result<Value> {
    
    case success(Value)
    case failure(Error)
}
