//
//  MovieDetailActions.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 23/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//

import Foundation
import ReSwift

struct SetMovieDetailAction : Action {
    
    var movie: Movie
    
    init(_ movie: Movie) {
        self.movie = movie
    }
}
