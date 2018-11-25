//
//  Vehicle+CoreDataProperties.swift
//  Assignment10 library
//
//  Created by Chung-Yang Li on 11/24/18.
//  Copyright © 2018 Chung-Yang Li. All rights reserved.
//
//

import Foundation
import CoreData


extension Vehicle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Vehicle> {
        return NSFetchRequest<Vehicle>(entityName: "Vehicle")
    }

    @NSManaged public var make: String?
    @NSManaged public var miles: Double
    @NSManaged public var model: String?
    @NSManaged public var photo: String?
    @NSManaged public var price: Double
    @NSManaged public var rating: Int32
    @NSManaged public var type: String?
    @NSManaged public var year: NSDate?
    @NSManaged public var id: Int32
    @NSManaged public var department: Department?

}
