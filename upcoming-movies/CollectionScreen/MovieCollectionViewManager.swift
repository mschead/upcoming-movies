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
    
    func makeFetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    func applyFilter(text: String) {
        self.fetchedResultsController.fetchRequest.predicate = NSPredicate(format: "name LIKE[c] %@", "*\(text)*")
        self.makeFetch()
        self.collectionView.reloadData()
    }
    
    func removeFilter() {
        self.fetchedResultsController.fetchRequest.predicate = nil
        self.makeFetch()
        self.collectionView.reloadData()
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
        
        let width = collectionView.frame.size.width - 20 //+ 10
//        let insetLeft = collectionViewLayout.collectionView?.layoutMargins.left ?? 0
//        let insetRight = collectionViewLayout.collectionView?.layoutMargins.right ?? 0
        
        var widthCell = width / 2
        var heightCell = width * 0.9
        
        if (width > 600) {
            widthCell = width / 3
            heightCell = width * 0.5
        }
        
        return CGSize(width: widthCell, height: heightCell)
    }
    
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        if type == .insert {
//            collectionView.insertItems(at: [newIndexPath!])
//        }
//    }

    var blockOperations: [BlockOperation] = []
    
//    var fetchedResultController: NSFetchedResultsController<Entity> {
//        if _fetchedResultsController != nil {
//            return _fetchedResultsController!
//        }
//
//        let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest()
//        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext!
//
//        fetchRequest.predicate = NSPredicate(format: "...")
//
//        // sort by item text
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "...", ascending: true)]
//        let resultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
//
//        resultsController.delegate = self;
//        _fetchedResultsController = resultsController
//
//        do {
//            try _fetchedResultsController!.performFetch()
//        } catch {
//            let nserror = error as NSError
//            fatalError("Unresolved error \(nserror)")
//        }
//        return _fetchedResultsController!
//    }
    
    var shouldReloadCollectionView: Bool = false
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        if type == NSFetchedResultsChangeType.insert {
            print("Insert Object: \(newIndexPath)")
            
            if (collectionView.numberOfSections) > 0 {
                
                if collectionView.numberOfItems( inSection: newIndexPath!.section ) == 0 {
                    self.shouldReloadCollectionView = true
                } else {
                    blockOperations.append(
                        BlockOperation(block: { [weak self] in
                            if let this = self {
                                DispatchQueue.main.async {
                                    this.collectionView.insertItems(at: [newIndexPath!])
                                }
                            }
                        })
                    )
                }
                
            } else {
                self.shouldReloadCollectionView = true
            }
        }
        else if type == NSFetchedResultsChangeType.update {
            print("Update Object: \(indexPath)")
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        DispatchQueue.main.async {
                            
                            this.collectionView.reloadItems(at: [indexPath!])
                        }
                    }
                })
            )
        }
        else if type == NSFetchedResultsChangeType.move {
            print("Move Object: \(indexPath)")
            
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        DispatchQueue.main.async {
                            this.collectionView.moveItem(at: indexPath!, to: newIndexPath!)
                        }
                    }
                })
            )
        }
        else if type == NSFetchedResultsChangeType.delete {
            print("Delete Object: \(indexPath)")
            if collectionView.numberOfItems( inSection: indexPath!.section ) == 1 {
                self.shouldReloadCollectionView = true
            } else {
                blockOperations.append(
                    BlockOperation(block: { [weak self] in
                        if let this = self {
                            DispatchQueue.main.async {
                                this.collectionView.deleteItems(at: [indexPath!])
                            }
                        }
                    })
                )
            }
        }
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        if type == NSFetchedResultsChangeType.insert {
            print("Insert Section: \(sectionIndex)")
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        DispatchQueue.main.async {
                            this.collectionView.insertSections(NSIndexSet(index: sectionIndex) as IndexSet)
                        }
                    }
                })
            )
        }
        else if type == NSFetchedResultsChangeType.update {
            print("Update Section: \(sectionIndex)")
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        DispatchQueue.main.async {
                            this.collectionView.reloadSections(NSIndexSet(index: sectionIndex) as IndexSet)
                        }
                    }
                })
            )
        }
        else if type == NSFetchedResultsChangeType.delete {
            print("Delete Section: \(sectionIndex)")
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        DispatchQueue.main.async {
                            this.collectionView.deleteSections(NSIndexSet(index: sectionIndex) as IndexSet)
                        }
                    }
                })
            )
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        // Checks if we should reload the collection view to fix a bug @ http://openradar.appspot.com/12954582
        if (self.shouldReloadCollectionView) {
            DispatchQueue.main.async {
                self.collectionView.reloadData();
            }
        } else {
            DispatchQueue.main.async {
                self.collectionView.performBatchUpdates({ () -> Void in
                    for operation: BlockOperation in self.blockOperations {
                        operation.start()
                    }
                }, completion: { (finished) -> Void in
                    self.blockOperations.removeAll(keepingCapacity: false)
                })
            }
        }
    }
    
    deinit {
        for operation: BlockOperation in blockOperations {
            operation.cancel()
        }
        blockOperations.removeAll(keepingCapacity: false)
    }
    

}
