//
//  ViewController.swift
//  Assignment6 library2
//
//  Created by Chung-Yang Li on 10/26/18.
//  Copyright © 2018 Chung-Yang Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
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
        print("Num: \(indexPath.row)")
        let v = vehicles[indexPath.row]
        
        let screenBounds = UIScreen.main.bounds
        let width = screenBounds.width
        let height = screenBounds.height
        
        let textView = UITextView(frame: CGRect(x: 0, y: 60, width: width, height: height))
        textView.backgroundColor = .white
        textView.alpha = 0.95
        textView.tag = 100
        textView.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 30)
        textView.isScrollEnabled = true
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy"
        let year = dateformatter.string(from: v.year)
        
        let str = "\n Make: \(v.make)\n Miles: \(v.miles)\n Model: \(v.model)\n Photo: \(v.photo)\n Price: \(v.price)\n Rating: \(v.rating)\n Type: \(v.type)\n Year: \(year)\n\n"
        textView.text.append(str)

        
        self.view.addSubview(textView)
        
        let aSelector : Selector = #selector(ViewController.removeSubview)
        let tapGesture = UITapGestureRecognizer(target:self, action: aSelector)
        textView.addGestureRecognizer(tapGesture)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! MyCell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.vehicle = vehicles[indexPath.row]
        
//        cell.textLabel!.text = "\(vehicles[indexPath.row].type)"
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

//    func deleteCell(cell: UITableViewCell){
//        if let deleteIndexPath = tableView.indexPathForCell(cell){
//            tableView.deleteRow
//        }
//    }
    
    
    
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
        navigationItem.title = "Vehicles"
        
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
//        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.register(MyCell.self, forCellReuseIdentifier: "MyCell")
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
    }
    /* add vehicles*/
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

class MyCell: UITableViewCell{
//    let nameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "123"
//    }()
    let vehicleTitleDetailedLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
//        label.textColor =  colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        label.backgroundColor =  colorLiteral(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    let actionButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Delete", for: .normal)
        return btn
    }()
    let profileImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
//        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
//    var myTableViewController: ViewController?
    var vehicle:Vehicle? {
        didSet {
            guard let vehicleItem = vehicle else {return}
            
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy"
            let year = dateformatter.string(from: vehicleItem.year)
            nameLabel.text = vehicleItem.make
            profileImageView.image = UIImage(named: vehicleItem.photo)
            vehicleTitleDetailedLabel.text = vehicleItem.model + "  " + year
        
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews(){
//        addSubview(nameLabel)
//        addSubview(actionButton)
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(vehicleTitleDetailedLabel)
        self.contentView.addSubview(containerView)
        
        profileImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
//            containerView auto layout constraints
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.profileImageView.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:60).isActive = true
//            nameLabel auto layout constraints
        
        nameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
            
//            vehicleTitleDetailedLabel auto layout constraints
        
        vehicleTitleDetailedLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
        vehicleTitleDetailedLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        vehicleTitleDetailedLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
        vehicleTitleDetailedLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        
//        actionButton.addTarget(self, action: "Action", for: .touchUpInside)
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[message]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": actionButton]));
    }
    func Action(){
//        myTableViewController.deleteCell(self)
    }
}

