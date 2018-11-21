//
//  DetailViewController.swift
//  Assignment9
//
//  Created by Chung-Yang Li on 11/13/18.
//  Copyright © 2018 Chung-Yang Li. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var make: UILabel!
    @IBOutlet weak var miles: UILabel!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var txtMake: String = ""
    var txtMiles: String = ""
    var txtModel: String = ""
    var txtPrice: String = ""
    var txtRating: String = ""
    var txtType: String = ""
    var txtYear: String = ""
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        make.text = txtMake
        miles.text = txtMiles
        model.text = txtModel
        price.text = txtPrice
        rating.text = txtRating
        type.text = txtType
        year.text = txtYear
        img.image = image
        // Do any additional setup after loading the view.
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
