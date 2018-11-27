//
//  AddVehicleViewController.swift
//  Assignment9
//
//  Created by Chung-Yang Li on 11/13/18.
//  Copyright © 2018 Chung-Yang Li. All rights reserved.
//

import UIKit

class AddVehicleViewController: UIViewController {


    @IBOutlet weak var txt1: UITextField!
    @IBOutlet weak var txt2: UITextField!
    @IBOutlet weak var txt3: UITextField!
    @IBOutlet weak var txt4: UITextField!
    @IBOutlet weak var txt5: UITextField!
    @IBOutlet weak var txt6: UITextField!
    @IBOutlet weak var txt7: UITextField!
    @IBOutlet weak var txt8: UITextField!
    @IBOutlet weak var img: UIImageView!
    
//    @IBAction func camera(_ sender: UIButton) {
//        imagePicker.delegate = self
//        imagePicker.sourceType = UIImagePickerController.SourceType.camera
//        self.present(imagePicker, animated: true, completion: nil)
//    }
//    }
//    @IBAction func gallery(_ sender: UIButton) {
//        imagePicker.delegate = self
//        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
//        self.present(imagePicker, animated: true, completion: nil)
//    }
    
    
    var department: Department!
    var maxid = 0

    var imagePicker = UIImagePickerController()
    var pickedImageProduct = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTapGesture()
        print(department)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Add(_ sender: UIButton) {
        let alert = UIAlertController(title: "Alert", message: "Please check your typing", preferredStyle: UIAlertController.Style.alert)
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

//        let year = dateformatter.date(from: txt8.text!)

        let context = getContext()
        let vehicle1 = Vehicle(context: context)
        let year = dateformatter.date(from: txt8.text!) as NSDate?
        vehicle1.make = txt1.text!
        vehicle1.miles = d2
        vehicle1.model = txt3.text!
        vehicle1.photo = txt4.text!
        vehicle1.price = d5
        vehicle1.rating = Int32(i6)
        vehicle1.type = txt7.text!
        vehicle1.year = year!
        vehicle1.id = Int32(maxid)
        vehicle1.department = department
        department?.addToVehicles(vehicle1)
        //        department1?.vehicles?.forEach({print($0)})
        maxid += 1
        
        
        
//        let vehicle1 = Vehicle(txt1.text!, d2, txt3.text!, txt4.text!, d5, i6, txt7.text!, year!)
//        department.Add(vehicle: vehicle1)
        txt1.text = ""
        txt2.text = ""
        txt3.text = ""
        txt4.text = ""
        txt5.text = ""
        txt6.text = ""
        txt7.text = ""
        txt8.text = ""
    }
    //    @IBAction func Add(_ sender: UIButton) {
//        let alert = UIAlertController(title: "Alert", message: "Please check your typing", preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        //verify textFields
//        if !txt1.text!.isAlpha(ignoreDiacritics: true) { alert.show(); return}
//        if !txt3.text!.isAlpha(ignoreDiacritics: true) { alert.show(); return}
//        if !txt4.text!.isAlpha(ignoreDiacritics: true) { alert.show(); return}
//        if !txt7.text!.isAlpha(ignoreDiacritics: true) { alert.show(); return}
//        guard txt8.text!.count == 4 else{alert.show(); return}
//
//        guard let d2 = Double(txt2.text!) else{alert.show(); return}
//        guard let d5 = Double(txt5.text!) else{alert.show(); return}
//        //        let d5 = NSString(string: textField5.text!).doubleValue
//        guard let i6 = Int(txt6.text!) else{alert.show(); return}
//
//        let dateformatter = DateFormatter()
//        dateformatter.dateFormat = "yyyy"
//
//        let year = dateformatter.date(from: txt8.text!)
//
//        let vehicle1 = Vehicle(txt1.text!, d2, txt3.text!, txt4.text!, d5, i6, txt7.text!, year!)
//        department.Add(vehicle: vehicle1)
//        txt1.text = ""
//        txt2.text = ""
//        txt3.text = ""
//        txt4.text = ""
//        txt5.text = ""
//        txt6.text = ""
//        txt7.text = ""
//        txt8.text = ""
//    }
    
    private func configureTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddVehicleViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap(){
        view.endEditing(true)
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

extension AddVehicleViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}

extension AddVehicleViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func camera(_ sender: UIButton) {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func gallery(_ sender: UIButton) {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Error: \(info)")
            return
        }
        
        pickedImageProduct = selectedImage
        img.image = pickedImageProduct
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
//    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
//        guard let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
//            dismiss(animated: true, completion: nil)
//            return
//        }
//        img.image = chosenImage
//        dismiss(animated: true, completion: nil)
//    }
//
//    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }
    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
//        self.dismiss(animated: true, completion: nil)
////        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//
//        img.image = info[UIImagePickerControllerOriginalImage] as? UIImage
////        imgSelected1.image  = selectedImage
//    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
//        guard let selectedImage = info[.originalImage] as? UIImage else {
//            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
//        }
//        img.image = selectedImage
//        dismiss(animated: true, completion: nil)
//    }
}
