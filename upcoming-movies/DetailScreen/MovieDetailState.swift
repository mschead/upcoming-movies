//
//  MovieDetailState.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 23/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//

import Foundation
import UIKit
import ReSwift

struct MovieDetailState : StateType {
    
    var movieImage: UIImage?
    var name = String()
    var genre = String()
    var releaseDate = String()
    var overview = String()
    
}
