//
//  configureBusiness.swift
//  test
//
//  Created by Chung-Yang Li on 10/23/18.
//  Copyright © 2018 Chung-Yang Li. All rights reserved.
//

import Foundation

func configureBusiness()-> Department{
    let currentdate = Date()
    let dateformatter = DateFormatter()
    //dateformatter.dateFormat = "yyyy"
    //let nameofMonth = dateformatter.string(from: currentdate)
    //print(nameofMonth)

    var str1 = "2016-10-05"
    dateformatter.dateFormat = "yyyy-mm-dd"
    var date1 = dateformatter.date(from: str1)

    let vehicle1 = Vehicle("Lamborghini", 2.0, "HURACAN", "", 200000, 1, "Coupe", date1!)

    let department1 = Department("Sales","510-679-7777")
    return department1
}
