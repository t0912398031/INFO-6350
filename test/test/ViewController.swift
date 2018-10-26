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
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configureTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    private func configureTextFields(){
        txt1.delegate = self
        txt2.delegate = self
        txt3.delegate = self
        txt4.delegate = self
    }
    
    @IBAction func addVehicle(_ sender: Any) {
        //verify textFields
        if !txt1.text!.isAlpha(ignoreDiacritics: true) {
            print("Please enter valid name")
            return
        }
        guard txt8.text!.characters.count == 4 else{return}
 
        let dateformatter = DateFormatter()
        var str1 = "2016"
        dateformatter.dateFormat = "yyyy"
        
        let date1 = dateformatter.date(from: txt8.text!)

        let d2 = NSString(string: txt2.text!).doubleValue
        let d5 = NSString(string: txt5.text!).doubleValue
        let i6 = Int(txt6.text!)
        
        let vehicle1 = Vehicle(txt1.text!, d2, txt3.text!, txt4.text!, d5, i6!, txt7.text!, date1!)
        
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
        department1.List()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destViewController : ViewList = segue.destination as! ViewList
        
        
        destViewController.labelTxt = String(department1.vehicles[0].ID)
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
}
