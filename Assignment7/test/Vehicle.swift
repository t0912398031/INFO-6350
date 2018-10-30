//
//  Vehicle.swift
//  Assignment5
//
//  Created by lipang on 10/19/18.
//  Copyright © 2018 lipang. All rights reserved.
//

import UIKit


class Vehicle: NSObject  {
    var ID: Int = 0
    var make: String
    var miles: Double
    var model: String
    var photo: String
    var price: Double
    var rating: Int
    var type: String
    var year: Date
    
    init(_ make: String, _ miles: Double, _ model: String, _ photo: String, _ price: Double, _ rating: Int, _ type: String, _ year: Date){
        self.ID += 1
        self.make = make
        self.miles = miles
        self.model = model
        self.photo = photo
        self.price = price
        self.rating = rating
        self.type = type
        self.year = year
    }
}
