//
//  ViewController.swift
//  Assignment10 library
//
//  Created by Chung-Yang Li on 11/20/18.
//  Copyright © 2018 Chung-Yang Li. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

//    var department : NSManagedObject()
//    var vehicles: [NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        resetAllRecords(in: "Department")
        resetAllRecords(in: "Vehicle")
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let department = Department(context: managedContext)
        department.name = "789"


//        appDelegate.saveContext()
        
        
        let fetchRequest: NSFetchRequest<Department> = Department.fetchRequest()
        do{
            let department1 = try managedContext.fetch(fetchRequest)
            print(department1)
            print(department1[0].name)
//            print(department1[1].name)
//            print(department1[2].name)
//            print(department1[3].name)
//            department1[0].name = "456"

        } catch{

        }

//        let departmentEntity = NSEntityDescription.entity(forEntityName: "Department", in: managedContext)!
////
////
//        let d = NSManagedObject(entity: departmentEntity, insertInto: managedContext)
//        d.setValue("Northeastern", forKeyPath: "name")
//        d.setValue("5106797777", forKey: "phone")
//
//        appDelegate.saveContext()
        
        
//
        let vehicleEntity = NSEntityDescription.entity(forEntityName: "Vehicle", in: managedContext)!
        let car1 = NSManagedObject(entity: vehicleEntity, insertInto: managedContext)
        car1.setValue("Audi TT", forKey: "model")
//        car1.setValue(2010, forKey: "year")
//        car1.setValue(department, forKey: "vehicle")
        department.addToVehicles(car1 as! Vehicle)
        let VfetchRequest: NSFetchRequest<Vehicle> = Vehicle.fetchRequest()
        do{
            let a = try managedContext.fetch(VfetchRequest)
            print(a)
            
        } catch{
            
        }
        print(department.vehicles)
////        let car2 = NSManagedObject(entity: vehicleEntity, insertInto: managedContext)
////        car2.setValue("BMW X6", forKey: "model")
//////        car2.setValue(2014, forKey: "year")
////        car2.setValue(department, forKey: "vehicle")
////
 
//        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Department")

//        userFetch.fetchLimit = 1

//        userFetch.predicate = NSPredicate(format: "name = %@", "Northeastern")
//        let users = try! managedContext.fetch(userFetch)
//
//        let john: Department = users.first as! Department
//        print("Email: \(john.name!)")
//        print()
//        let johnCars = john.cars?.allObjects as! [Car]
//        print("has \(johnCars.count)")
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//
//        
//        let department = NSE
//        
//        let department = Department(context: context)
//        

        let alert = UIAlertController(title: "Add", message: nil, preferredStyle: .alert)
        alert.addTextField{(textField) in textField.placeholder = "Name"}
        present(alert, animated: true, completion: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }

}

public extension UIViewController{
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func resetAllRecords(in entity : String) // entity = Your_Entity_Name
    {
        
        let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
            try context.save()
        }
        catch
        {
            print ("There was an error")
        }
    }
}

public extension String{
    func isAlpha(ignoreDiacritics: Bool = false) -> Bool {
        if ignoreDiacritics {
            return self.range(of: "[^a-zA-Z]", options: .regularExpression) == nil && self != ""
        }
        else {
            return self.isAlpha()
        }
    }
    func isAlphaNum(ignoreDiacritics: Bool = false) -> Bool {
        if ignoreDiacritics {
            return self.range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil && self != ""
        }
        else {
            return self.isAlpha()
        }
    }
}

public extension UIAlertController {
    func show() {
        let win = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        win.rootViewController = vc
        win.windowLevel = UIWindow.Level.alert + 1
        win.makeKeyAndVisible()
        vc.present(self, animated: true, completion: nil)
    }
}
