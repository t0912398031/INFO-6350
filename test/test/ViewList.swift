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
    
    @IBOutlet weak var txt1: UILabel!
    
    var labelTxt = String()
    override func viewDidLoad() {
        txt1.text = labelTxt
        
    }
    
}
