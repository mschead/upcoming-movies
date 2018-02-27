//
//  MovieDetailActions.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 23/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//

import Foundation
import ReSwift
import UIKit

struct SetMovieDetailAction : Action {
    
    var movie: Movie
    var image: UIImage
    
    init(_ movie: Movie, _ image: UIImage) {
        self.movie = movie
        self.image = image
    }
}
