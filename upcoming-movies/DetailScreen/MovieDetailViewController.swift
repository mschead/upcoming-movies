//
//  MovieDetailViewController.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 23/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//

import UIKit
import ReSwift

class MovieDetailViewController: UIViewController, StoreSubscriber {

    typealias StoreSubscriberStateType = MovieDetailState
    
    @IBOutlet weak var movieView: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configMovieView()
        
        mainStore.subscribe(self, selector: {$0.movieDetailState})
    }
    
    func newState(state: MovieDetailState) {
        movieImage.image = state.movieImage
        name.text = state.name
        genre.text = state.genres
        releaseDate.text = state.releaseDate
        overview.text = state.overview
    }
    
    fileprivate func configMovieView() {
        movieView.layer.cornerRadius = 3
        movieView.layer.shadowColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        movieView.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        movieView.layer.shadowRadius = 1.7
        movieView.layer.shadowOpacity = 0.45
    }

}
