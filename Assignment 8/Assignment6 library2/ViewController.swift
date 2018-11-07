//
//  ViewController.swift
//  Assignment6 library2
//
//  Created by Chung-Yang Li on 10/26/18.
//  Copyright © 2018 Chung-Yang Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
//                print("Value: \(myArray[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! MyCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(vehicles[indexPath.row].type)"
//        cell.myTableViewController = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {

            vehicles.remove(at: indexPath.row)
            myTableView.deleteRows(at: [indexPath], with: .fade)
//            myTableView.reloadData()
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
//    func deleteCell(cell: UITableViewCell){
//        if let deleteIndexPath = tableView.indexPathForCell(cell){
//            tableView.deleteRow
//        }
//    }
    
    
    
    private func configureVehicles(){
        let dateformatter = DateFormatter()
        let str1 = "2018"
        dateformatter.dateFormat = "yyyy"
        let date1 = dateformatter.date(from: str1)
        
        let vehicle1 = Vehicle("Lamborghini", 2.0, "HURACAN", "", 200000, 1, "Coupe", date1!)
        let vehicle2 = Vehicle("Lamborghini", 2.0, "HURACAN", "", 200000, 1, "Coup", date1!)
        let vehicle3 = Vehicle("Lamborghini", 2.0, "HURACAN", "", 200000, 1, "Cou", date1!)
        let vehicle4 = Vehicle("Lamborghini", 2.0, "HURACAN", "", 200000, 1, "Co", date1!)
        department1.Add(vehicle: vehicle1)
        department1.Add(vehicle: vehicle2)
        department1.Add(vehicle: vehicle3)
        department1.Add(vehicle: vehicle4)
    }

    public var myTableView: UITableView!
    var department1 = Department("Sales","510-679-7777")
    private let myArray: NSArray = ["First","Second","Third"]
    var vehicles: [Vehicle] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vehicles = department1.vehicles
//        print(vehicles.count)
        myTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVehicles()
        vehicles = department1.List()
//        tableView.registerClass(MyCell.self, forCellReuseIdentifier: "cellId")
        
        
        let addButton = UIBarButtonItem(barButtonSystemItem:.add,
                                        target: self,
                                        action: #selector(addAction))

        navigationItem.rightBarButtonItem = addButton
        
        let deleteButton = UIBarButtonItem(barButtonSystemItem:.edit,
                                        target: self,
                                        action: #selector(editAction))
        
        navigationItem.leftBarButtonItem = deleteButton
        
        
        /*table view*/
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
//        let refreshControl = UIRefreshControl()
        myTableView = UITableView(frame: CGRect(x: 0, y: 50, width: displayWidth, height: displayHeight - barHeight))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.isScrollEnabled = true
//        myTableView.refreshControl = refreshControl

        
        view.addSubview(myTableView)
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    @objc func addAction(){
        let objVC: ListViewController? = ListViewController(nibName: nil, bundle: nil)
        objVC?.department = department1
        navigationController?.pushViewController(objVC!, animated: true)
        
//        let dateformatter = DateFormatter()
//        let str1 = "2018"
//        dateformatter.dateFormat = "yyyy"
//        let date1 = dateformatter.date(from: str1)
//        let vehicle = Vehicle("Lamborghini", 2.0, "HURACAN", "", 200000, 1, "A", date1!)
////        department1.Add(vehicle: vehicle)
//        vehicles.append(vehicle)
//        myTableView.reloadData()
//        print(vehicles.count)

        vehicles = department1.vehicles
        myTableView.reloadData()
        print(vehicles.count)

//        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
//        let displayWidth: CGFloat = self.view.frame.width
//        let displayHeight: CGFloat = self.view.frame.height
//        let myTableView2 = UITableView(frame: CGRect(x: 0, y: 50, width: displayWidth, height: displayHeight - barHeight))
//        myTableView2.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
//        myTableView2.dataSource = self
//        myTableView2.delegate = self
//        myTableView2.isScrollEnabled = true
//        view.addSubview(myTableView2)


        
    }
    @objc func editAction(){
        myTableView.setEditing(true, animated: true)
        
        let backButton = UIBarButtonItem(barButtonSystemItem:.done,
                                           target: self,
                                           action: #selector(back))
        
        navigationItem.leftBarButtonItem = backButton
    }
    @objc func back(){
        myTableView.setEditing(false, animated: true)
        let addButton = UIBarButtonItem(barButtonSystemItem:.edit,
                                        target: self,
                                        action: #selector(editAction))
        
        navigationItem.leftBarButtonItem = addButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//class MyCell: UITableViewCell{
////    let nameLabel: UILabel = {
////        let label = UILabel()
////        label.text = "123"
////    }()
//    let actionButton: UIButton = {
//        let btn = UIButton()
//        btn.setTitle("Delete", for: .normal)
//        return btn
//    }()
//    var myTableViewController: ViewController?
//
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupViews()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setupViews(){
////        addSubview(nameLabel)
//        addSubview(actionButton)
//
//        actionButton.addTarget(self, action: "Action", for: .touchUpInside)
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[message]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": actionButton]));
//    }
//    func Action(){
////        myTableViewController.deleteCell(self)
//    }
//}

