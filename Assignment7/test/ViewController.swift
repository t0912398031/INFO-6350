//
//  ViewController.swift
//  test
//
//  Created by Chung-Yang Li on 10/23/18.
//  Copyright © 2018 Chung-Yang Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txt1: UITextField!
    @IBOutlet weak var txt2: UITextField!
    @IBOutlet weak var txt3: UITextField!
    @IBOutlet weak var txt4: UITextField!
    @IBOutlet weak var txt5: UITextField!
    @IBOutlet weak var txt6: UITextField!
    @IBOutlet weak var txt7: UITextField!
    @IBOutlet weak var txt8: UITextField!
    
    var department1 = Department("Sales","510-679-7777")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        configureTapGesture()
        configureVehicles()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configureTextFields(){
        txt1.delegate = self
        txt2.delegate = self
        txt3.delegate = self
        txt4.delegate = self
        txt5.delegate = self
        txt6.delegate = self
        txt7.delegate = self
        txt8.delegate = self
    }
    
//    dismiss keyboard
    private func configureTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap(){
        view.endEditing(true)
    }

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
    
    @IBAction func addVehicle(_ sender: Any) {

        let alert = UIAlertController(title: "Alert", message: "Please check your typing", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        //verify textFields
        if !txt1.text!.isAlpha(ignoreDiacritics: true) { alert.show(); return}
        if !txt3.text!.isAlpha(ignoreDiacritics: true) { alert.show(); return}
        if !txt4.text!.isAlpha(ignoreDiacritics: true) { alert.show(); return}
        if !txt7.text!.isAlpha(ignoreDiacritics: true) { alert.show(); return}
        guard txt8.text!.count == 4 else{alert.show(); return}
        
        guard let d2 = Double(txt2.text!) else{alert.show(); return}
        guard let d5 = Double(txt5.text!) else{alert.show(); return}
        //        let d5 = NSString(string: textField5.text!).doubleValue
        guard let i6 = Int(txt6.text!) else{alert.show(); return}
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy"
        
        let year = dateformatter.date(from: txt8.text!)
        
        let vehicle1 = Vehicle(txt1.text!, d2, txt3.text!, txt4.text!, d5, i6, txt7.text!, year!)
        
        department1.Add(vehicle: vehicle1)
        txt1.text = ""
        txt2.text = ""
        txt3.text = ""
        txt4.text = ""
        txt5.text = ""
        txt6.text = ""
        txt7.text = ""
        txt8.text = ""
    }
    
    @IBAction func listVehicle(_ sender: Any) {
        
//        department1.List()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "List"){
            let destViewController : ViewList = segue.destination as! ViewList
            destViewController.department = department1
        }
        if(segue.identifier == "Search"){
            let destViewController : ViewSearch = segue.destination as! ViewSearch
            destViewController.department = department1
        }

    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident == "List" {
                if department1.vehicles.capacity <= 0{
                    let alert = UIAlertController(title: "Alert", message: "No Vehicles", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                    return false
                }
            }
        }
        return true
    }
    
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}

 extension String{
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
        win.windowLevel = UIWindowLevelAlert + 1
        win.makeKeyAndVisible()
        vc.present(self, animated: true, completion: nil)
    }
}
