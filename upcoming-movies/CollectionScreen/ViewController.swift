//
//  ViewController.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 22/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var moviesCollectionView: UICollectionView!

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    @IBOutlet weak var infoActivity: UILabel!
    
    var buttonCopy: UIBarButtonItem!
    
    let moviesRequester = MoviesRequester()
    var manager: MovieCollectionViewManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        buttonCopy = self.navigationItem.rightBarButtonItem
        
        manager = MovieCollectionViewManager(collectionView: moviesCollectionView)
        manager.initializeFetchedResultsController()
        
        self.moviesCollectionView.delegate = manager
        self.moviesCollectionView.dataSource = manager
        
        loadCollectionInfo()
    }
    
    @IBAction func onSearchClick(_ sender: Any) {
        createSearchBar()
    }
    
    fileprivate func createSearchBar() {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Type your movie here!"
        searchBar.delegate = self
        
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.titleView = searchBar
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationItem.title = "Upcoming Movies"
        self.navigationItem.rightBarButtonItem = buttonCopy
        self.navigationItem.titleView = nil
    }
    
    fileprivate func loadCollectionInfo() {
        let moviesDatabase = manager.fetchedResultsController.fetchedObjects ?? []
        let moviesPersistence = MoviesPersistence()
        
        if moviesDatabase.isEmpty {
            moviesRequester.makeFirstPageRequest() { (result) in
                switch result {
                case .success(let page):
                    page.results.forEach { (movieWrapper) in
                        let genres = self.getMovieGenresNames(genresId: movieWrapper.genreIds, genresWrapper: self.moviesRequester.genres)
                        moviesPersistence.save(movie: movieWrapper, genres: genres)
                    }
                    
                    self.getOtherPages(totalPages: page.total_pages)
                    
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
    
    
    func getMovieGenresNames(genresId: [Int], genresWrapper: [GenreWrapper]) -> String {
        var genresNames: [String] = []
        
        genresId.forEach { id in
            genresWrapper.forEach { genreWrapper in
                if genreWrapper.id == id {
                    genresNames.append(genreWrapper.name)
                }
            }
        }
        
        return genresNames.joined(separator: ", ")
    }
    
    
    fileprivate func getOtherPages(totalPages: Int) {
        let moviesPersistence = MoviesPersistence()
        
        for pageNumber in 2...9 {
            moviesRequester.makeMovieRequest(page: pageNumber) { (result) in
                switch result {
                case .success(let page):
                    page.results.forEach { (movieWrapper) in
                        let genres = self.getMovieGenresNames(genresId: movieWrapper.genreIds, genresWrapper: self.moviesRequester.genres)
                        moviesPersistence.save(movie: movieWrapper, genres: genres)
                    }
                    
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            }
        }

    }
    
    
    
    
}

