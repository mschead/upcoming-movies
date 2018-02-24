//
//  MovieCollectionViewCollectionViewCell.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 22/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!

    func setFieldValue(movie: Movie) {
        movieImage.downloadImageFrom(link: "https://image.tmdb.org/t/p/w300" + movie.urlImage!, contentMode: UIViewContentMode.redraw)
    }

}
