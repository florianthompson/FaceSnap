//
//  PhotoFetchedResultsController.swift
//  Facesnap
//
//  Created by Florian Thompson on 04/09/16.
//  Copyright © 2016 Florian Thompson. All rights reserved.
//

import CoreData
import UIKit

class PhotoFetchedResultsController: NSFetchedResultsController, NSFetchedResultsControllerDelegate {
    
    private let collectionView: UICollectionView

    init(fetchRequest: NSFetchRequest, managedObjectContext: NSManagedObjectContext, collectionView: UICollectionView) {
        
        self.collectionView = collectionView
        
        super.init(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        self.delegate = self
        
        executeFetch()
    }
    
    func executeFetch() {
        do {
            try performFetch()
        } catch let error as NSError {
            print("Fetch failed with error: \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        collectionView.reloadData()
    }
}
