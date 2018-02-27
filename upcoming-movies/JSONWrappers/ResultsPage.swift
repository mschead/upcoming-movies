//
//  ResultsPage.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 23/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//

import Foundation

struct ResultsPage : Codable {
    
    var results: [MovieWrapper]
    var total_pages: Int
    
}
