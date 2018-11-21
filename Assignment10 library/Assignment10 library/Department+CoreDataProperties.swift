//
//  Department+CoreDataProperties.swift
//  Assignment10 library
//
//  Created by Chung-Yang Li on 11/20/18.
//  Copyright © 2018 Chung-Yang Li. All rights reserved.
//
//

import Foundation
import CoreData


extension Department {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Department> {
        return NSFetchRequest<Department>(entityName: "Department")
    }

    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var employees: NSObject?
    @NSManaged public var vehicles: NSSet?

}

// MARK: Generated accessors for vehicles
extension Department {

    @objc(addVehiclesObject:)
    @NSManaged public func addToVehicles(_ value: Vehicle)

    @objc(removeVehiclesObject:)
    @NSManaged public func removeFromVehicles(_ value: Vehicle)

    @objc(addVehicles:)
    @NSManaged public func addToVehicles(_ values: NSSet)

    @objc(removeVehicles:)
    @NSManaged public func removeFromVehicles(_ values: NSSet)

}
