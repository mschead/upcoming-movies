//
//  MovieCollectionViewManager.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 23/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MovieCollectionViewManager : NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {

    var collectionView: UICollectionView
    var fetchedResultsController: NSFetchedResultsController<Movie>
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        
        let request = NSFetchRequest<Movie>(entityName: "Movie")
        let titleSort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [titleSort]
        
        let moc = NSManagedObjectContext.mr_default()
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    func initializeFetchedResultsController() {
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCollectionCell", for: indexPath) as! MovieCollectionViewCell
        
        let object = self.fetchedResultsController.object(at: indexPath)
        
        cell.setFieldValue(movie: object)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MovieCollectionViewCell
        
        let object = self.fetchedResultsController.object(at: indexPath)
        
        mainStore.dispatch(SetMovieDetailAction(object, cell.movieImage.image!))
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
    

    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .insert {
            collectionView.insertItems(at: [newIndexPath!])
        }
    }
    

}
