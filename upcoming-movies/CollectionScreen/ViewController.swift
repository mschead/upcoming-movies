//
//  ViewController.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 22/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var moviesCollectionView: UICollectionView!

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    @IBOutlet weak var infoActivity: UILabel!
    
    var manager: MovieCollectionViewManager!
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        manager = MovieCollectionViewManager(collectionView: moviesCollectionView)
        
        self.moviesCollectionView.delegate = manager
        self.moviesCollectionView.dataSource = manager
        
        loadCollectionInfo()
    }
    
    fileprivate func loadCollectionInfo() {
        MoviesRequester().makeRequest() { (result) in
            switch result {
            case .success(let pages):
                let movies = pages.results.map { (movieWrapper) -> Movie in
                    let movie = Movie()
                    movie.name = movieWrapper.title
                    movie.overview = movieWrapper.overview
                    movie.releaseDate = movieWrapper.releaseDate
                    movie.urlImage = "https://image.tmdb.org/t/p/w300" + movieWrapper.posterPath
                    return movie
                }
                
                self.manager.movies = movies
                self.manager.collectionView.reloadData()
                
                self.infoView.isHidden = true
                self.moviesCollectionView.isHidden = false
                
            case .failure(let error):
                print("error: \(error.localizedDescription)")
                
                self.indicatorActivity.stopAnimating()
                self.infoActivity.text = "Error fetching the movies. Try reopening the app!"
                
            }
        }
    }
    
}

