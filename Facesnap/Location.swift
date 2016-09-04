//
//  Location.swift
//  Facesnap
//
//  Created by Florian Thompson on 04/09/16.
//  Copyright © 2016 Florian Thompson. All rights reserved.
//

import Foundation
import CoreData

class Location: NSManagedObject {
    static let entityName = "\(Location.self)"
    
    class func locationWith(latitude: Double, longitude: Double) -> Location {
        let location = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: CoreDataController.sharedInstance.managedObjectContext) as! Location
        
        location.latitude = latitude
        location.longitude = longitude
        
        return location
    }

}

extension Location {
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
}