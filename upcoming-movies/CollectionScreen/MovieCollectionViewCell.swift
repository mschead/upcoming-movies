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
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 5
    }
    
    func setFieldValue(movie: Movie) {
        title.text = movie.name ?? "-"
        genres.text = movie.genres ?? "-"
        releaseDate.text = movie.releaseDate ?? "-"
        if movie.urlImage != "no-poster" {
            movieImage.downloadImageFrom(link: "https://image.tmdb.org/t/p/w300" + movie.urlImage!, contentMode: UIViewContentMode.redraw)
        } else {
            movieImage.image = UIImage(named: "no-thumb")
        }
        
    }

}
