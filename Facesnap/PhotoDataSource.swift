//
//  PhotoDataSource.swift
//  Facesnap
//
//  Created by Florian Thompson on 04/09/16.
//  Copyright © 2016 Florian Thompson. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PhotoDataSource: NSObject {
    private var collectionView: UICollectionView
    private let managedObjectContext = CoreDataController.sharedInstance.managedObjectContext
    private let fetchedResultsController: PhotoFetchedResultsController
    
    init(fetchRequest: NSFetchRequest, collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.fetchedResultsController = PhotoFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, collectionView: collectionView)
        
        super.init()
    }
}

// MARK: - UICollectionViewDataSource
extension PhotoDataSource: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else { return 0 }
        
        return section.numberOfObjects
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoCell.reuseIdentifier, forIndexPath: indexPath) as! PhotoCell
        
        let photo = fetchedResultsController.objectAtIndexPath(indexPath) as! Photo
        cell.imageView.image = photo.photoImage
        
        return cell
    }
}
