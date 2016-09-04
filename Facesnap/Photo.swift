//
//  Photo.swift
//  Facesnap
//
//  Created by Florian Thompson on 04/09/16.
//  Copyright © 2016 Florian Thompson. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import CoreLocation

class Photo: NSManagedObject {
    static let entitiyName = "\(Photo.self)"
    
    static var allPhotosRequest: NSFetchRequest = {
        let request = NSFetchRequest(entityName: Photo.entitiyName)
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]        
        return request
    }()
    class func photo(withImage image: UIImage) -> Photo {
        let photo = NSEntityDescription.insertNewObjectForEntityForName(entitiyName, inManagedObjectContext: CoreDataController.sharedInstance.managedObjectContext) as! Photo
        
        photo.date = NSDate().timeIntervalSince1970
        photo.image = UIImageJPEGRepresentation(image, 1.0)!
        
        return photo
    }
    
    class func photoWith(image: UIImage, tags: [String], location: CLLocation?) {
        let photo = Photo.photo(withImage: image)
        photo.addTags(tags)
        photo.addLocation(location)
    }
    
    func addTag(withTitle title: String) {
        let tag = Tag.tag(withTitle: title)
        tags.insert(tag)
    }
    
    func addTags(tags: [String]) {
        for tag in tags {
            addTag(withTitle: tag)
        }
    }
    
    func addLocation(location: CLLocation?) {
        if let location = location {
            let photoLocation = Location.locationWith(location.coordinate.latitude, longitude: location.coordinate.longitude)
            self.location = photoLocation
        }
    }
}

extension Photo {
    @NSManaged var date: NSTimeInterval
    @NSManaged var image: NSData
    @NSManaged var tags: Set<Tag>
    @NSManaged var location: Location?
    
    var photoImage: UIImage {
        return UIImage(data: image)!
    }
}