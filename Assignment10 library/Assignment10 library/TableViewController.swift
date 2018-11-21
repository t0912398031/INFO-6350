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
    private func configureVehicles(){
//        let dateformatter = DateFormatter()
//        dateformatter.dateFormat = "yyyy"
//        let date1 = dateformatter.date(from: "2016")
//        let date2 = dateformatter.date(from: "2018")
//        let date3 = dateformatter.date(from: "2017")
//        let vehicle1 = Vehicle("Lamborghini", 2.0, "HURACAN SPYDER", "2016 Lamborghini Huracan LP610-4 Spyder", 200000, 1, "Coupe", date1!)
//        let vehicle2 = Vehicle("Lamborghini", 2.0, "HURACAN PERFORMANTE", "2018-lamborghini-huracan-performante", 200000, 1, "Coup", date2!)
//        let vehicle3 = Vehicle("Lamborghini", 2.0, "HURACAN RWD", "huracan-rwd", 200000, 1, "Cou", date2!)
//        let vehicle4 = Vehicle("Lamborghini", 2.0, "HURACAN", "2017-Lamborghini-Huracan", 200000, 1, "Co", date3!)
//        department1.Add(vehicle: vehicle1)
//        department1.Add(vehicle: vehicle2)
//        department1.Add(vehicle: vehicle3)
//        department1.Add(vehicle: vehicle4)
    }
    


    @IBAction func addVehicle(_ sender: UIBarButtonItem) {
        createVehicle()
        getVehicles()
        
        tableView.reloadData()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.saveContext()
        
    }
    @IBOutlet weak var tableView: UITableView!

//    var departments = [Department]()
    var department1 : Department?

    private let myArray: NSArray = ["First","Second","Third"]
    var vehicles = [Vehicle]()
//    var vehicles: [NSManagedObject] = []
//    var vehicles: NSSet?
    @NSManaged var types : Set<Vehicle>
    var array = ["123","234","345"]
    
    
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
//        deleteRecords()

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
//    func resetAllRecords(in entity : String) // entity = Your_Entity_Name
//    {
//
//        let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
//        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
//        do
//        {
//            try context.execute(deleteRequest)
//            try context.save()
//        }
//        catch
//        {
//            print ("There was an error")
//        }
//    }
    
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
    }
    
    func getDepartments(){
        let context = getContext()
        guard let departments = try! context.fetch(Department.fetchRequest()) as? [Department] else { return }
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
        department1?.addToVehicles(vehicle1)
//        department1?.vehicles?.forEach({print($0)})
    }
    
    func getVehicles(){
//        let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
//        guard let vehicles = try! context.fetch(Vehicle.fetchRequest()) as? [Vehicle] else { return }
     
        vehicles = department1?.vehicles?.allObjects  as! [Vehicle]
        vehicles.forEach({print($0)})
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
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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
        

        
//        let vehicle = vehicles[indexPath.row]
//        let dateformatter = DateFormatter()
//        dateformatter.dateFormat = "yyyy"
//        let year = dateformatter.string(from: vehicle.value(forKeyPath: "year") as! Date)
//
//        cell.img.image = UIImage(named: vehicle.value(forKeyPath: "photo") as? String ?? "")
//        cell.label1.text = vehicle.value(forKeyPath: "model") as? String
//        cell.label2.text = vehicle.value(forKeyPath: "type") as? String
//        cell.label3.text = "\(year)"
//        cell.label1.text = "123"
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy"
        let year = dateformatter.string(from: vehicles[indexPath.row].year! as Date)
        
        
        cell.label1.text = vehicles[indexPath.row].model
        cell.label2.text = vehicles[indexPath.row].type
        cell.label3.text = "\(year)"
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
            
            vehicles.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
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
}
