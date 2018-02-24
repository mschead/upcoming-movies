//
//  MovieWrapper.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 23/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//

import Foundation

struct MovieWrapper : Codable {
    
    var title: String
    var posterPath: String
    var genreIds: [Int]
    var overview: String
    var releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
        case overview = "overview"
        case releaseDate = "release_date"
    }

    
    
}

