//
//  LoginViewController.swift
//  Chefulate
//
//  Created by Mahesh Kumar Kankipati on 11/12/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit
import Foundation
class LoginViewController: UIViewController,UITextFieldDelegate  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
 self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    

    @IBAction func signIn(_ sender: AnyObject) {
        getLoginData()
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
                let json = try JSONSerialization.jsonObject(with: result, options: .allowFragments)as? NSDictionary
                print("JSON data returned = \(json)")
                
            }catch {
                print("Error serializing JSON data : \(error)")
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
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(conversiontable.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
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

}
