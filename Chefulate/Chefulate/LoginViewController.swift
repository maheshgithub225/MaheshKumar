//
//  LoginViewController.swift
//  Chefulate
//
//  Created by Mahesh Kumar Kankipati on 11/12/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit
import Foundation

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flag = false
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    var json : NSDictionary = NSDictionary()
    var flag = Bool()
    
    var UID = 0
    var F_Name = "Guest"
    var L_Name = ""
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "guestUser" {
            let secondViewController = segue.destination as! SearchViewController
            secondViewController.UID = UID
            secondViewController.F_Name = F_Name
            secondViewController.L_Name = L_Name
            print("NAME : \(F_Name)")
            if(UID != 0){
                secondViewController.guestflag = false
            }
        }
    }
    
    @IBAction func signIn(_ sender: AnyObject) {
        let alertControl1 = UIAlertController(title: "Login Invalid", message: "Please enter right password", preferredStyle: .alert)
        let alertControl2 = UIAlertController(title: "Login Invalid", message: "Please enter correct Email ID", preferredStyle: .alert)
        let alertControl3 = UIAlertController(title: "Login Invalid", message: "Email ID and Password cannot be blank", preferredStyle: .alert)
        
        let okay = UIAlertAction(title: "Okay", style: .destructive){
            (result : UIAlertAction) in debugPrint("Okay")
        }
        if userName.text == "" && password.text != "" {
            alertControl1.addAction(okay)
            self.present(alertControl1, animated: true, completion: nil)
        } else if userName.text != "" && password.text == "" {
            alertControl2.addAction(okay)
            self.present(alertControl2, animated: true, completion: nil)
        } else if userName.text == "" && password.text == "" {
            alertControl3.addAction(okay)
            alertControl3.view.backgroundColor = UIColor.black
            self.present(alertControl3, animated: true, completion: nil)
        } else {
            getLoginData()
            while self.flag == false {}
            self.getalertData()
        }
    }
    
    func getLoginData(){
        let emailID = self.userName.text!
        let Password = self.password.text!
        
        let url = URL(string: "https://cs.okstate.edu/~jtsutto/services.php/1/\(emailID)/\(Password)")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url!){ (data, response, error)in
            guard error == nil else {
                print("Error in session call \(error)")
                return
            }
            guard let result = data else {
                print("No data received")
                return
            }
            do {
                self.json = try JSONSerialization.jsonObject(with: result, options: .allowFragments)as! NSDictionary
                print("JSON data returned = \(self.json)")
                self.flag = true
                
            }catch {
                print("Error serializing JSON data : \(error)")
            }
        }
        task.resume()
    }
    
    func getalertData(){
        let data = self.json["DATA"] as! NSString
        if data == "Email Does Not Exist" {
            let alertControl4 = UIAlertController(title: "Login Invalid", message: "Email Does not Exist", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Okay", style: .destructive){
                (result : UIAlertAction) in debugPrint("Okay")
            }
            alertControl4.addAction(okay)
            self.present(alertControl4, animated: true, completion: nil)
            return
        }
        if data == "Invalid Email" {
            let alertControl5 = UIAlertController(title: "Login Invalid", message: "Invalid Email", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Okay", style: .destructive){
                (result : UIAlertAction) in debugPrint("Okay")
            }
            alertControl5.addAction(okay)
            self.present(alertControl5, animated: true, completion: nil)
            return
        }
        
        getUserData()
        
    }
    
    func getUserData(){
        let emailID = self.userName.text!
        let Password = self.password.text!
        self.flag = false

        let url = URL(string: "https://cs.okstate.edu/~jtsutto/services.php/15/\(emailID)/\(Password)")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url!){ (data, response, error)in
            guard error == nil else {
                print("Error in session call \(error)")
                return
            }
            guard let result = data else {
                print("No data received")
                return
            }
            var json: NSDictionary
            do {
                json = try JSONSerialization.jsonObject(with: result, options: .allowFragments)as! NSDictionary
                let obj = json["User"] as! NSDictionary
                if(obj["Error"] == nil){
                    self.F_Name = obj["First_Name"] as! String
                    self.L_Name = obj["Last_Name"] as! String
                    self.UID = (Int)(obj["UID"] as! String)!
                    self.flag = true
                }
                print("JSON data returned = \(json)")
            }catch {
                print("Error serializing JSON data : \(error)")
            }
            DispatchQueue.main.async{
                self.performSegue(withIdentifier: "guestUser", sender: nil)
            }
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    //    func hideKeyboardWhenTappedAround() {
    //        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(conversiontable.dismissKeyboard))
    //        view.addGestureRecognizer(tap)
    //    }
    
    func dismissKeyboard() {
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
    
      @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}  
    
}
