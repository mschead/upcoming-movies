//
//  MovieCollectionViewManager.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 23/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//

import Foundation
import UIKit

class MovieCollectionViewManager : NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var collectionView: UICollectionView
    var movies: [Movie]
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        movies = MoviesService().getMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCollectionCell", for: indexPath) as! MovieCollectionViewCell
        cell.setFieldValue(movie: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width + 10
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.movies[indexPath.row]
        mainStore.dispatch(SetMovieDetailAction(movie))
    }

}
