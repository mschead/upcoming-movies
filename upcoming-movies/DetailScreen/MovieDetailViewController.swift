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
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainStore.subscribe(self, selector: {$0.movieDetailState})
    }
    
    func newState(state: MovieDetailState) {
//        movieImage.image = U
        name.text = state.name
        genre.text = state.genre
        releaseDate.text = state.releaseDate
        overview.text = state.overview
    }

}
