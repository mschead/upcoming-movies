//
//  MoviesPersistence.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 24/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//

import Foundation
import MagicalRecord

class MoviesPersistence {
    
    func save(movie: MovieWrapper, genres: String) {
        let movieDB = Movie.mr_createEntity()!
        
        movieDB.setValue(movie.title, forKey: "name")
        movieDB.setValue(movie.overview, forKey: "overview")
        movieDB.setValue(movie.posterPath, forKey: "urlImage")
        movieDB.setValue(movie.releaseDate, forKey: "releaseDate")
        movieDB.setValue(genres, forKey: "genres")
        
        NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
    }
    
    func load() -> [NSManagedObject] {
        let context = NSManagedObjectContext.mr_default()
        return Movie.mr_findAll(in: context) ?? []
    }
    
}
