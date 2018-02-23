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

    var manager: MovieCollectionViewManager!
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        manager = MovieCollectionViewManager(collectionView: moviesCollectionView)
        
        self.moviesCollectionView.delegate = manager
        self.moviesCollectionView.dataSource = manager
    }

}

