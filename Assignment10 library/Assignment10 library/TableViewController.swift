//
//  TableViewController.swift
//  Assignment9
//
//  Created by Chung-Yang Li on 11/13/18.
//  Copyright © 2018 Chung-Yang Li. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UIViewController, UITableViewDelegate{
    
    @IBAction func test(_ sender: Any) {
        print(getVehicle(id: "2"))
    }
    @IBAction func addVehicle(_ sender: UIBarButtonItem) {
        createVehicle()
//        getVehicles()
        
        tableView.reloadData()
        save()
        
    }
    @IBOutlet weak var tableView: UITableView!

//    var departments = [Department]()
    var department1 : Department?

//    var vehicles = [Vehicle]()
    var vehicles: [NSManagedObject] = []
    
    var count = 0


    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        vehicles = fetchDepartment()
        //        print(vehicles.count)
        tableView.reloadData()
    }
    
//    func fetchDepartment() -> [Department1]{
//        let fetchRequest: NSFetchRequest<Department1> = Department1.fetchRequest()
//        do{
//            let department1 = try managedContext.fetch(fetchRequest)
//        } catch{
//
//        }
//        return department1
//    }
    
//    var managedContext: NSManagedObjectContext

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetAllRecords(in: "Vehicle")
        deleteRecords()

        getDepartments()
        getVehicles()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func deleteRecords() -> Void {
        let moc = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Department")
        
        let result = try? moc.fetch(fetchRequest)
        let resultData = result as! [Department]
        
        for object in resultData {
            moc.delete(object)
        }
        
        do {
            try moc.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
    }
    
    // MARK: Get Context
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func save() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.saveContext()
    }
    
    func update() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Department")
        do{
            let result = try managedContext.fetch(fetchRequest)
            let objectUpdate = result[0] as! NSManagedObject
//            objectUpdate.setValue(department1)
        }
        catch{
            print("update error")
        }
        
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
    
//    func clearCoreDataStore() {
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        let context = delegate.persistentContainer.viewContext
//
//        for i in 0...delegate.persistentContainer.managedObjectModel.entities.count-1 {
//            let entity = delegate.persistentContainer.managedObjectModel.entities[i]
//
//            do {
//                let query = NSFetchRequest<NSFetchRequestResult>(entityName: entity.name!)
//                let deleterequest = NSBatchDeleteRequest(fetchRequest: query)
//                try context.execute(deleterequest)
//                try context.save()
//
//            } catch let error as NSError {
//                print("Error: \(error.localizedDescription)")
//                abort()
//            }
//        }
//    }
    
    func createDepartment(){
//        let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
        let context = getContext()
        department1 = Department(context: context)
        department1?.name = "Northeastern"
        print("Department been created")
    }
    
    func getDepartments(){
        let context = getContext()
        guard let departments = try! context.fetch(Department.fetchRequest()) as? [Department] else { return}
//        departments.forEach({print($0.name)})
        if departments.capacity == 0 { createDepartment() }
        else{
            department1 = departments[0]                //temporary use first one
            //            print(departments.capacity)
        }
    }
    
    func createVehicle(){
        let context = getContext()
        let vehicle1 = Vehicle(context: context)
  
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy"
        let date1 = dateformatter.date(from: "2016") as NSDate?
        vehicle1.model = "Lamborghini"
        vehicle1.type = "Coupe"
        vehicle1.year = date1!
        vehicle1.id = Int32(count)
        vehicle1.department = department1
        department1?.addToVehicles(vehicle1)
//        department1?.vehicles?.forEach({print($0)})
        count += 1
        
        
        vehicles = department1?.vehicles?.allObjects  as! [Vehicle]
    }
    
    func getVehicles(){
        vehicles = department1?.vehicles?.allObjects  as! [Vehicle]
//        vehicles.forEach({print($0.model)})
        
        for v in vehicles {
            if let id = v.value(forKeyPath: "id") as? Int{
                if id > count{
                    count = id
                }
            }
            else{print("no id")}
            
        }
    
        
//        let context = getContext()
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Vehicle")
//        fetchRequest.predicate = NSPredicate(format: "id = %@", "departnemt1")
//        do{
//            let v = try context.fetch(fetchRequest)
//            print(v)
//        }
//        catch {
//            print("fetch error")
//        }
        
//        guard let v = try! context.fetch(Vehicle.fetchRequest()) as? [Vehicle] else { return}
        
    }
    
    func getVehicle(id: String) -> NSManagedObject?{
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Vehicle")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        do{
            let vs = try context.fetch(fetchRequest)
            let v = vs[0] as! NSManagedObject
            return v
        }
        catch {
            print("fetch error")
        }
        return nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "Add"){
//            let destViewController : AddVehicleViewController = segue.destination as! AddVehicleViewController
//            destViewController.department = department1
//        }
        
    }
    
//    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
//        if let ident = identifier {
//            if ident == "List" {
//                if department1.vehicles.capacity <= 0{
//                    let alert = UIAlertController(title: "Alert", message: "No Vehicles", preferredStyle: UIAlertControllerStyle.alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                    self.present(alert, animated: true)
//
//                    return false
//                }
//            }
//        }
//        return true
//    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath as IndexPath) as! TableViewCell
//                        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath as IndexPath)
        

        
        let vehicle = vehicles[indexPath.row]
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy"
        let year = dateformatter.string(from: vehicle.value(forKeyPath: "year") as! Date)

//        cell.img.image = UIImage(named: vehicle.value(forKeyPath: "photo") as? String ?? "")
//        cell.label1.text = vehicle.value(forKeyPath: "model") as? String
        cell.label1.text = String((vehicle.value(forKey: "id") as? Int)!)
        cell.label2.text = vehicle.value(forKeyPath: "type") as? String
        cell.label3.text = "\(year)"

        
        
        
        
        
        
        
        
//        let dateformatter = DateFormatter()
//        dateformatter.dateFormat = "yyyy"
//        let year = dateformatter.string(from: vehicles[indexPath.row].year! as Date)
//
//
//        cell.label1.text = vehicles[indexPath.row].model
//        cell.label2.text = vehicles[indexPath.row].type
//        cell.label3.text = "\(year)"
        return cell
    }

    
    /* click action */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        let dateformatter = DateFormatter()
//        dateformatter.dateFormat = "yyyy"
//        let year = dateformatter.string(from: vehicles[indexPath.row].year)
//
//        var dc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
//
//        dc?.txtMake = vehicles[indexPath.row].make
//        dc?.txtMiles = String(vehicles[indexPath.row].miles)
//        dc?.txtModel = vehicles[indexPath.row].model
//        dc?.txtRating = String(vehicles[indexPath.row].rating)
//        dc?.txtPrice = String(vehicles[indexPath.row].price)
//        dc?.txtType = vehicles[indexPath.row].type
//        dc?.txtYear = year
//        dc?.image = UIImage(named: vehicles[indexPath.row].photo)
//
//        self.navigationController?.pushViewController(dc!, animated: true)
//
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicles.count
//        return 3
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
  
            
            
            let vehicle = vehicles[indexPath.row]
            guard let deleteObject = getVehicle(id: String((vehicle.value(forKey: "id") as? Int)!)) else{ print("deleteObject not found");return}
            print(deleteObject)
            getContext().delete(deleteObject)
            
            vehicles.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            save()
            //            myTableView.reloadData()
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 100
    //    }
    
    // MARK: - Table view data source
    
    //    func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
}
