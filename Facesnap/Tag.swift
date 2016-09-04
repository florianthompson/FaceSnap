//
//  Tag.swift
//  Facesnap
//
//  Created by Florian Thompson on 04/09/16.
//  Copyright © 2016 Florian Thompson. All rights reserved.
//

import Foundation
import CoreData

class Tag: NSManagedObject {
    static let entityName = "\(Tag.self)"
    
    static var allTagsRequest: NSFetchRequest = {
       let request = NSFetchRequest(entityName: Tag.entityName)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        return request
    }()
    
    class func tag(withTitle title: String) -> Tag {
        let tag = NSEntityDescription.insertNewObjectForEntityForName(Tag.entityName, inManagedObjectContext: CoreDataController.sharedInstance.managedObjectContext) as! Tag
        
        tag.title = title
        
        return tag
    }
    
}

extension Tag {
    @NSManaged var title: String
}