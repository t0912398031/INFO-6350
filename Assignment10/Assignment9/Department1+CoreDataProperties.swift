//
//  Department1+CoreDataProperties.swift
//  Assignment10
//
//  Created by Chung-Yang Li on 11/20/18.
//  Copyright © 2018 Chung-Yang Li. All rights reserved.
//
//

import Foundation
import CoreData


extension Department1 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Department1> {
        return NSFetchRequest<Department1>(entityName: "Department1")
    }

    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var vehicles: NSSet?

}

// MARK: Generated accessors for vehicles
extension Department1 {

    @objc(addVehiclesObject:)
    @NSManaged public func addToVehicles(_ value: Vehicle1)

    @objc(removeVehiclesObject:)
    @NSManaged public func removeFromVehicles(_ value: Vehicle1)

    @objc(addVehicles:)
    @NSManaged public func addToVehicles(_ values: NSSet)

    @objc(removeVehicles:)
    @NSManaged public func removeFromVehicles(_ values: NSSet)

}
