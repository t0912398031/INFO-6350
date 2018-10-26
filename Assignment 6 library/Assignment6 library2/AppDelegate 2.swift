//
//  AppDelegate.swift
//  Assignment6
//
//  Created by lipang on 10/22/18.
//  Copyright © 2018 lipang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITextFieldDelegate, UITextViewDelegate {

    var window: UIWindow?
    var view = UIView()
    var textField1 = UITextField()
    var textField2 = UITextField()
    var textField3 = UITextField()
    var textField4 = UITextField()
    var textField5 = UITextField()
    var textField6 = UITextField()
    var textField7 = UITextField()
    var textField8 = UITextField()
    var searchTxtField = UITextField()
    var btn1 = UIButton()
    var btn2 = UIButton()
    var btn3 = UIButton()
    var textView = UITextView()
    var searchView = UITextView()
    var backbtn = UIButton()
  
    let department1 = Department("Sales","510-679-7777")
    
    func createTextField(_ num: Int) -> UITextField {
        
        let textField = UITextField(frame: CGRect(x:50.0, y:Double(num)*50, width:200.0, height:30.0))
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.
        textField.resignFirstResponder()
        return true
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
    
    func createButton(_ num: Int) -> UIButton{
        var size = num
        if num == 3{size = 1}
        let btn:UIButton = UIButton(frame: CGRect(x: 0 + 100*Double(size), y: 500, width: 80, height: 40))
        switch num{
        case 0: btn.setTitle("Add", for: .normal)
                    btn.addTarget(self, action:#selector(buttonAction), for: .touchUpInside)
            case 1: btn.setTitle("List", for: .normal)
                    btn.addTarget(self, action:#selector(buttonAction1), for: .touchUpInside)
            case 2: btn.setTitle("Search", for: .normal)
                    btn.addTarget(self, action:#selector(buttonAction2), for: .touchUpInside)
            case 3: btn.setTitle("Back", for: .normal)
                    btn.addTarget(self, action:#selector(buttonAction3), for: .touchUpInside)
                    btn.tag = 2
        default: print("")
        }
        btn.layer.cornerRadius = 20.0
        btn.layer.borderColor = UIColor.red.cgColor
        btn.layer.borderWidth = 2.0
        btn.backgroundColor = UIColor.brown
        
        return btn
    }
    
//    "Add" Button
    @objc func buttonAction(sender: UIButton!){
        //verify textFields
        if !textField1.text!.isAlpha(ignoreDiacritics: true) {
            print("Please enter valid name")
            return
        }
        guard textField8.text!.characters.count == 4 else{return}
        
        let dateformatter = DateFormatter()
        var str1 = "2016"
        dateformatter.dateFormat = "yyyy"
        
        let date1 = dateformatter.date(from: textField8.text!)
        
        let d2 = NSString(string: textField2.text!).doubleValue
        let d5 = NSString(string: textField5.text!).doubleValue
        let i6 = Int(textField6.text!)
        
        let vehicle1 = Vehicle(textField1.text!, d2, textField3.text!, textField4.text!, d5, i6!, textField7.text!, date1!)
        
        department1.Add(vehicle: vehicle1)
        textField1.text = ""
        textField2.text = ""
        textField3.text = ""
        textField4.text = ""
        textField5.text = ""
        textField6.text = ""
        textField7.text = ""
        textField8.text = ""
    }
//    "List" Button
    @objc func buttonAction1(sender: UIButton!){
        let vehicles = department1.List()

        textView = UITextView(frame: CGRect(x:0,y:0,width:400, height:600))
        textView.tag = 1
        textView.delegate = self
        for v in vehicles{
            let str = "\(v.make),\(v.miles),\(v.model),\(v.photo),\(v.price),\(v.rating),\(v.type),\(v.year)\n"
            textView.text.append(str)
        }
        
        view.addSubview(textView)
        
        backbtn = createButton(3)
        view.addSubview(backbtn)
        
        
    }
//    "Search" Button
    @objc func buttonAction2(sender: UIButton!){
        searchView = UITextView(frame: CGRect(x:0,y:0,width:400, height:600))
        searchView.tag = 1
        searchView.delegate = self
        view.addSubview(searchView)
        
        searchTxtField = UITextField(frame: CGRect(x:50.0, y:50, width:200.0, height:30.0))
        searchTxtField.placeholder = "Type(String)orYear(YYYY)"
        searchTxtField.delegate = self
        searchTxtField.tag = 3
        view.addSubview(searchTxtField)
        
        let searchbtn:UIButton = UIButton(frame: CGRect(x:100, y: 400, width: 80, height: 40))
        searchbtn.setTitle("Go", for: .normal)
        searchbtn.addTarget(self, action:#selector(buttonAction4), for: .touchUpInside)
        searchbtn.tag = 4
        searchbtn.layer.cornerRadius = 20.0
        searchbtn.layer.borderColor = UIColor.red.cgColor
        searchbtn.layer.borderWidth = 2.0
        searchbtn.backgroundColor = UIColor.brown
        view.addSubview(searchbtn)
        
        backbtn = createButton(3)
        view.addSubview(backbtn)
    }
//    "Back" Button
    @objc func buttonAction3(sender: UIButton!){
        if let viewWithTag = view.viewWithTag(1){
            viewWithTag.removeFromSuperview()
        }
        if let viewWithTag = view.viewWithTag(2){
            viewWithTag.removeFromSuperview()
        }
        if let viewWithTag = view.viewWithTag(3){
            viewWithTag.removeFromSuperview()
        }
        if let viewWithTag = view.viewWithTag(4){
            viewWithTag.removeFromSuperview()
        }
    }
//    "Go" Button
    @objc func buttonAction4(sender: UIButton!){
        guard let txt = searchTxtField.text, !txt.isEmpty else{
            print("Please enter something")
            return
        }
        if !searchTxtField.text!.isAlphaNum(ignoreDiacritics: true) {
            print("Please enter valid search type")
            return
        }
        if let searchType: Int = Int(searchTxtField.text ?? "0"){
            guard searchTxtField.text!.characters.count == 4 else{return}
            if let vehicles = department1.Search(search: "year", str: searchTxtField.text!){
                for v in vehicles{
                    let str = "\(v.make),\(v.miles),\(v.model),\(v.photo),\(v.price),\(v.rating),\(v.type),\(v.year)\n"
                    searchView.text.append(str)
                }
            }
        }
        else {
            if let vehicles = department1.Search(search: "type", str: searchTxtField.text!){
                for v in vehicles{
                    let str = "\(v.make),\(v.miles),\(v.model),\(v.photo),\(v.price),\(v.rating),\(v.type),\(v.year)\n"
                    searchView.text.append(str)
                }
            }
        }
        
        
    }
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            window.backgroundColor = UIColor.white
            window.rootViewController = UIViewController()
            window.makeKeyAndVisible()
        }
        let viewRect: CGRect = CGRect(x:20,y:20,width:400, height:600);
        view = UIView(frame:viewRect)
        window?.addSubview(view); // window is coming soon
        
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
        
        btn1 = createButton(0)
        btn2 = createButton(1)
        btn3 = createButton(2)
        view.addSubview(btn1)
        view.addSubview(btn2)
        view.addSubview(btn3)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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

