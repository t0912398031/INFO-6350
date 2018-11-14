//
//  TableViewController.swift
//  Assignment9
//
//  Created by Chung-Yang Li on 11/13/18.
//  Copyright © 2018 Chung-Yang Li. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private func configureVehicles(){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy"
        let date1 = dateformatter.date(from: "2016")
        let date2 = dateformatter.date(from: "2018")
        let date3 = dateformatter.date(from: "2017")
        let vehicle1 = Vehicle("Lamborghini", 2.0, "HURACAN SPYDER", "2016 Lamborghini Huracan LP610-4 Spyder", 200000, 1, "Coupe", date1!)
        let vehicle2 = Vehicle("Lamborghini", 2.0, "HURACAN PERFORMANTE", "2018-lamborghini-huracan-performante", 200000, 1, "Coup", date2!)
        let vehicle3 = Vehicle("Lamborghini", 2.0, "HURACAN RWD", "huracan-rwd", 200000, 1, "Cou", date2!)
        let vehicle4 = Vehicle("Lamborghini", 2.0, "HURACAN", "2017-Lamborghini-Huracan", 200000, 1, "Co", date3!)
        department1.Add(vehicle: vehicle1)
        department1.Add(vehicle: vehicle2)
        department1.Add(vehicle: vehicle3)
        department1.Add(vehicle: vehicle4)
    }
    

    @IBOutlet weak var tableView: UITableView!
    var department1 = Department("Sales","510-679-7777")
    private let myArray: NSArray = ["First","Second","Third"]
    var vehicles: [Vehicle] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vehicles = department1.vehicles
        //        print(vehicles.count)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.title = "Vehicles"
        
        configureVehicles()
        vehicles = department1.List()
        
//        tableView.backgroundColor = .red
//        tableView.register(TableViewCell.self, forCellReuseIdentifier: "myCell")
//        tableView.dataSource = self
//        tableView.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
    

    @objc func removeSubview(){
        print("Start remove sibview")
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }else{
            print("No!")
        }
    }
    /* click action */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Num: \(indexPath.row)")
//        let v = vehicles[indexPath.row]
//
//        let screenBounds = UIScreen.main.bounds
//        let width = screenBounds.width
//        let height = screenBounds.height
//
//        let textView = UITextView(frame: CGRect(x: 0, y: 60, width: width, height: height))
//        textView.backgroundColor = .white
//        textView.alpha = 0.95
//        textView.tag = 100
//        textView.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 30)
//        textView.isScrollEnabled = true
//        let dateformatter = DateFormatter()
//        dateformatter.dateFormat = "yyyy"
//        let year = dateformatter.string(from: v.year)
//
//        let str = "\n Make: \(v.make)\n Miles: \(v.miles)\n Model: \(v.model)\n Photo: \(v.photo)\n Price: \(v.price)\n Rating: \(v.rating)\n Type: \(v.type)\n Year: \(year)\n\n"
//        textView.text.append(str)
//
//
//        self.view.addSubview(textView)
//
//        let aSelector : Selector = #selector(TableViewController.removeSubview)
//        let tapGesture = UITapGestureRecognizer(target:self, action: aSelector)
//        textView.addGestureRecognizer(tapGesture)
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy"
        let year = dateformatter.string(from: vehicles[indexPath.row].year)
        
        var dc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController

        dc?.txtMake = vehicles[indexPath.row].make
        dc?.txtMiles = String(vehicles[indexPath.row].miles)
        dc?.txtModel = vehicles[indexPath.row].model
        dc?.txtRating = String(vehicles[indexPath.row].rating)
        dc?.txtPrice = String(vehicles[indexPath.row].price)
        dc?.txtType = vehicles[indexPath.row].type
        dc?.txtYear = year
        dc?.image = UIImage(named: vehicles[indexPath.row].photo)
        
        self.navigationController?.pushViewController(dc!, animated: true)
        
        
//        let vc = ViewList(nibName: "ListViewController", bundle: nil)
//        vc.department = department1
//        vc.modalTransitionStyle = .flipHorizontal
//        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath as IndexPath) as! TableViewCell
//                let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath as IndexPath)

//        cell.vehicle = vehicles[indexPath.row]

        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy"
        let year = dateformatter.string(from: vehicles[indexPath.row].year)
        
        cell.img.image = UIImage(named: vehicles[indexPath.row].photo)
        cell.label1.text = "\(vehicles[indexPath.row].model)"
        cell.label2.text = "\(vehicles[indexPath.row].type)"
        cell.label3.text = "\(year)"
//                cell.textLabel!.text = "\(vehicles[indexPath.row].type)"
        //        cell.myTableViewController = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
//
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "Add"){
            let destViewController : AddVehicleViewController = segue.destination as! AddVehicleViewController
            destViewController.department = department1
        }
//        if(segue.identifier == "Search"){
//            let destViewController : ViewSearch = segue.destination as! ViewSearch
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
