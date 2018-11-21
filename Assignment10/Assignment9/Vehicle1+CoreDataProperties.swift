//
//  Vehicle1+CoreDataProperties.swift
//  Assignment10
//
//  Created by Chung-Yang Li on 11/20/18.
//  Copyright © 2018 Chung-Yang Li. All rights reserved.
//
//

import Foundation
import CoreData


extension Vehicle1 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Vehicle1> {
        return NSFetchRequest<Vehicle1>(entityName: "Vehicle1")
    }

    @NSManaged public var make: String?
    @NSManaged public var miles: Double
    @NSManaged public var model: String?
    @NSManaged public var photo: String?
    @NSManaged public var price: Double
    @NSManaged public var rating: Int32
    @NSManaged public var type: String?
    @NSManaged public var year: NSDate?
    @NSManaged public var department: Department1?

}
