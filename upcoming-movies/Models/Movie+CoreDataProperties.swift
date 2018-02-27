//
//  Movie+CoreDataProperties.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 24/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var name: String?
    @NSManaged public var urlImage: String?
    @NSManaged public var genres: String?
    @NSManaged public var overview: String?
    @NSManaged public var releaseDate: String?

}
