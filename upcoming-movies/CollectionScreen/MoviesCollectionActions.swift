//
//  MoviesCollectionActions.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 26/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//

import Foundation
import ReSwift

struct SetSearchBarText : Action {
    
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
}
