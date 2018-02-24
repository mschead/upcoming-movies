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
        manager.initializeFetchedResultsController()
        
        self.moviesCollectionView.delegate = manager
        self.moviesCollectionView.dataSource = manager
        
        loadCollectionInfo()
    }
    
    fileprivate func loadCollectionInfo() {
        let moviesDatabase = manager.fetchedResultsController.fetchedObjects ?? []
        let moviesPersistence = MoviesPersistence()
        
        if moviesDatabase.isEmpty {
            MoviesRequester().makeRequest() { (result) in
                switch result {
                case .success(let pages):
                    pages.results.forEach { (movieWrapper) in
                        moviesPersistence.save(movie: movieWrapper)
                    }
                    
                    self.infoView.isHidden = true
                    self.moviesCollectionView.isHidden = false
                    
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                    
                    self.indicatorActivity.stopAnimating()
                    self.infoActivity.text = "Error fetching the movies. Try reopening the app!"
                    
                }
            }
        } else {
            self.infoView.isHidden = true
            self.moviesCollectionView.isHidden = false
        }
        

    }
    
}

