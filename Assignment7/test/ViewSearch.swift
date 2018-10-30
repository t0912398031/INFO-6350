//
//  ViewSearch.swift
//  test
//
//  Created by Chung-Yang Li on 10/30/18.
//  Copyright © 2018 Chung-Yang Li. All rights reserved.
//

import Foundation
import UIKit

class ViewSearch : UIViewController{
    

    var viewTxt = String()
    @IBOutlet weak var txtSearch: UITextField!
    var department: Department!
    
    @IBOutlet weak var txtView: UITextView!
    @IBAction func btnSearchVehicles(_ sender: Any) {
        view.endEditing(true)
        txtView.text?.removeAll()
        var result: String = ""
        
        let alert = UIAlertController(title: "Alert", message: "Please enter something", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        let alert2 = UIAlertController(title: "Alert", message: "Please enter valid search type", preferredStyle: UIAlertControllerStyle.alert)
        alert2.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        let alert3 = UIAlertController(title: "Alert", message: "Please enter valid year", preferredStyle: UIAlertControllerStyle.alert)
        alert3.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        guard let txt = txtSearch.text, !txt.isEmpty else{
            alert.show()
            return
        }
        if !txtSearch.text!.isAlphaNum(ignoreDiacritics: true) {
            alert2.show()
            return
        }
        if let input = Int(txtSearch.text ?? "0"){
            guard input > 1500 && input < 2019 else{alert3.show();return}
            if let vehicles = department.Search(search: "year", str: txtSearch.text!){
                for v in vehicles{
                    let dateformatter = DateFormatter()
                    dateformatter.dateFormat = "yyyy"
                    let year = dateformatter.string(from: v.year)
                    
                    let str = "Make: \(v.make)\n Miles: \(v.miles)\n Model: \(v.model)\n Photo: \(v.photo)\n Price: \(v.price)\n Rating: \(v.rating)\n Type: \(v.type)\n Year: \(year)\n\n"
                    result.append(str)
                }
            }
        }
        else {
            if let vehicles = department.Search(search: "type", str: txtSearch.text!){
                for v in vehicles{
                    let dateformatter = DateFormatter()
                    dateformatter.dateFormat = "yyyy"
                    let year = dateformatter.string(from: v.year)
                    
                    
                    let str = "Make: \(v.make)\n Miles: \(v.miles)\n Model: \(v.model)\n Photo: \(v.photo)\n Price: \(v.price)\n Rating: \(v.rating)\n Type: \(v.type)\n Year: \(year)\n\n"
                    result.append(str)
                }
            }
        }
        txtView.text.append(result)
    }
    
    
    
    override func viewDidLoad() {
//                txtView.text = ""
        
//        let vehicles = department.List()
//        txtView.text = vehicles
    }
    
    
}
