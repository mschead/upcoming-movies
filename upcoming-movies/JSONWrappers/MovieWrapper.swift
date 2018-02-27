//
//  MovieWrapper.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 23/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//

import Foundation

class MovieWrapper : Codable {
    
    var title: String = "Untitled"
    var posterPath: String = "no-poster"
    var genreIds: [Int] = []
    var overview: String = "No overview available"
    var releaseDate: String = "Release date unknown"
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
        case overview = "overview"
        case releaseDate = "release_date"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let title = try container.decodeIfPresent(String.self, forKey: .title) {
            self.title = title
        }
        
        if let posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) {
            self.posterPath = posterPath
        }
        
        if let genreIds = try container.decodeIfPresent([Int].self, forKey: .genreIds) {
            self.genreIds = genreIds
        }
        
        if let overview = try container.decodeIfPresent(String.self, forKey: .overview) {
            self.overview = overview
        }
        
        if let releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) {
            self.releaseDate = releaseDate
        }
    }

    
    
}

