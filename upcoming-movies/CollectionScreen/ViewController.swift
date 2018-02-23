//
//  ViewController.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 22/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    @IBOutlet weak var moviesCollectionView: UICollectionView!

    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        movies = MoviesService().getMovies()

        self.moviesCollectionView.delegate = self
        self.moviesCollectionView.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCollectionCell", for: indexPath) as! MovieCollectionViewCell
        cell.setFieldValue(movie: movies[0])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = self.view.frame.size.width;
        let insetLeft = collectionViewLayout.collectionView?.layoutMargins.left ?? 0
        let insetRight = collectionViewLayout.collectionView?.layoutMargins.right ?? 0

        let widthCell = width * 0.32
        let totalWidth = widthCell * 3 + insetLeft + insetRight + 5 + 5

        if (totalWidth < width) {
            return CGSize(width: width * 0.32, height: width * 0.32 * 1.54)
        } else {
            return CGSize(width: width * 0.3, height: width * 0.3 * 1.54)
        }
    }

    // check this!
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }

}

