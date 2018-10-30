//
//  ViewList.swift
//  test
//
//  Created by Chung-Yang Li on 10/23/18.
//  Copyright © 2018 Chung-Yang Li. All rights reserved.
//

import Foundation
import UIKit

class ViewList : UIViewController{
    
    var department: Department!
    @IBOutlet weak var txtView: UITextView!
    var viewTxt = String()
    
    override func viewDidLoad() {
//        txtView.text = viewTxt
        
        let vehicles = department.List()
        txtView.text = vehicles
    }
    
    
}
