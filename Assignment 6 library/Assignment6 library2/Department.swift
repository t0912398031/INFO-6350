//
//  Department.swift
//  Assignment6
//
//  Created by lipang on 10/22/18.
//  Copyright © 2018 lipang. All rights reserved.
//

import Foundation


class Department {
    var name: String
    var phone: String
    var employees: [Employee] = []
    var vehicles: [Vehicle] = []
    
    init(_ name: String, _ phone: String){
        self.name = name
        self.phone = phone
    }
    
    func Add (vehicle: Vehicle) {
        vehicles.append(vehicle)
    }
    
    func List ()->[Vehicle] {
//        for v in vehicles{
//            print(v)
//        }
        return vehicles
    }
    
    func Search (search: String, str: String) -> [Vehicle]? {
        
        var vehiclesArray : [Vehicle] = []
        for v in vehicles{
            switch search {
            case "type":
//                if v.type.contains(str){print("contains")}
                if v.type.range(of: str, options: .caseInsensitive) != nil{
                    vehiclesArray.append(v)
                }
//                if v.type.caseInsensitiveCompare(str) == .orderedSame{
//                    vehiclesArray.append(v)
//                }
            case "year":
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = "yyyy"
                let year = dateformatter.string(from: v.year)
                
                if year.caseInsensitiveCompare(str) == .orderedSame{
                    vehiclesArray.append(v)
                }
            default:
                print("vehicle not found")
                return nil
            }
        }
        return vehiclesArray
    }
}

class Dealer {
    var address: String
    var city: String
    var name: String
    var phone: String
    var zip: String
    var department: [Department] = []
    
    init(_ address: String, _ city: String, _ name: String, _ phone: String, _ zip: String){
        self.address = address
        self.city = city
        self.name = name
        self.phone = phone
        self.zip = zip
    }
}

class Employee {
    var address: String
    var city: String
    var firstname: String
    var lastname: String
    var phone: String
    var ssn: String
    var zip: String
    
    init(_ address: String, _ city: String, _ firstname: String, _ lastname: String, _ phone: String, _ ssn: String, _ zip: String){
        self.address = address
        self.city = city
        self.firstname = firstname
        self.lastname = lastname
        self.phone = phone
        self.ssn = ssn
        self.zip = zip
    }
}


//
//let currentdate = Date()
//let dateformatter = DateFormatter()
////dateformatter.dateFormat = "yyyy"
////let nameofMonth = dateformatter.string(from: currentdate)
////print(nameofMonth)
//
//var str1 = "2016-10-05"
//dateformatter.dateFormat = "yyyy-mm-dd"
//var date1 = dateformatter.date(from: str1)
//
//let vehicle1 = Vehicle("Lamborghini", 2.0, "HURACAN", "", 200000, 1, "Coupe", date1!)
//
//let department1 = Department("Sales","510-679-7777")
//department1.Add(vehicle: vehicle1)
//department1.List()
//if let v = department1.Search(search: "year", str: "2016"){
//    print(v)
//}
//else{
//    print("search cant found")
//}
//if let v2 = department1.Search(search: "type", str: "coupe"){
//    print(v2[0].make)
//}
//else{
//    print("search cant found")
//}
