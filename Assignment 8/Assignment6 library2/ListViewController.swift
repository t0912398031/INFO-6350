//
//  ListViewController.swift
//  Assignment6 library2
//
//  Created by Chung-Yang Li on 11/6/18.
//  Copyright © 2018 Chung-Yang Li. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITextFieldDelegate {

    var textField1 = UITextField()
    var textField2 = UITextField()
    var textField3 = UITextField()
    var textField4 = UITextField()
    var textField5 = UITextField()
    var textField6 = UITextField()
    var textField7 = UITextField()
    var textField8 = UITextField()
    var department: Department!
    
    func createTextField(_ num: Int) -> UITextField {
        
        let textField = UITextField(frame: CGRect(x:50.0, y:50+Double(num)*50, width:200.0, height:30.0))
        textField.textAlignment = NSTextAlignment.center
        textField.textColor = UIColor.blue
        textField.backgroundColor = UIColor.white
        textField.borderStyle = .line
        textField.autocapitalizationType = UITextAutocapitalizationType.words
        textField.clearButtonMode = .whileEditing
        switch num{
        case 1: textField.placeholder = "Enter Make(String)"
        case 2: textField.placeholder = "Enter Miles(Double)"
        case 3: textField.placeholder = "Enter Model(String)"
        case 4: textField.placeholder = "Enter Photo(String)"
        case 5: textField.placeholder = "Enter Price(Double)"
        case 6: textField.placeholder = "Enter Rating(Int)"
        case 7: textField.placeholder = "Enter Type(String)"
        case 8: textField.placeholder = "Enter Year(YYYY)"
        default:
            print("")
        }
        
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.delegate = self
        
        return textField
    }
    
    //    "Add" Button
    @objc func buttonAction(sender: UIButton!){
        let alert = UIAlertController(title: "Alert", message: "Please check your typing", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        //verify textFields
        if !textField1.text!.isAlpha(ignoreDiacritics: true) { alert.show(); return}
        if !textField3.text!.isAlpha(ignoreDiacritics: true) { alert.show(); return}
        if !textField4.text!.isAlpha(ignoreDiacritics: true) { alert.show(); return}
        if !textField7.text!.isAlpha(ignoreDiacritics: true) { alert.show(); return}
        guard textField8.text!.characters.count == 4 else{alert.show(); return}
        
        guard let d2 = Double(textField2.text!) else{alert.show(); return}
        guard let d5 = Double(textField5.text!) else{alert.show(); return}
        //        let d5 = NSString(string: textField5.text!).doubleValue
        guard let i6 = Int(textField6.text!) else{alert.show(); return}
        
        let dateformatter = DateFormatter()
        var str1 = "2016"
        dateformatter.dateFormat = "yyyy"
        
        let year = dateformatter.date(from: textField8.text!)
        
        let vehicle1 = Vehicle(textField1.text!, d2, textField3.text!, textField4.text!, d5, i6, textField7.text!, year!)
        
        department.Add(vehicle: vehicle1)
        //        textField1.text = ""
        //        textField2.text = ""
        //        textField3.text = ""
        //        textField4.text = ""
        //        textField5.text = ""
        //        textField6.text = ""
        //        textField7.text = ""
        //        textField8.text = ""
        let objVC: ViewController? = ViewController(nibName: nil, bundle: nil)
        
        objVC?.vehicles = department.vehicles
        print(department.vehicles.count)
//        objVC?.myTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        // Do any additional setup after loading the view.
        
        
        
        textField1 = createTextField(1)
        textField2 = createTextField(2)
        textField3 = createTextField(3)
        textField4 = createTextField(4)
        textField5 = createTextField(5)
        textField6 = createTextField(6)
        textField7 = createTextField(7)
        textField8 = createTextField(8)
        view.addSubview(textField1)
        view.addSubview(textField2)
        view.addSubview(textField3)
        view.addSubview(textField4)
        view.addSubview(textField5)
        view.addSubview(textField6)
        view.addSubview(textField7)
        view.addSubview(textField8)
        
        let btn:UIButton = UIButton(frame: CGRect(x: 20 + 100, y: 500, width: 80, height: 40))
        btn.setTitle("Add", for: .normal)
        btn.addTarget(self, action:#selector(buttonAction), for: .touchUpInside)
        view.addSubview(btn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
