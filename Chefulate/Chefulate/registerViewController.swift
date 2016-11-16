//  registerViewController.swift
//  Chefulate
//  Created by Bryan Reynolds on 10/17/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.


import UIKit
import Foundation

class registerViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var confirmEmail: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstName.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
        email.delegate = self
        confirmEmail.delegate = self
    }
    @IBAction func signUpButton(_ sender: AnyObject) {
        if (firstName.text?.isEmpty)!{
            self.firstName.text = "First Name is Missing"
            firstName.textColor = UIColor.red
            firstName.isHidden = false
            firstName.backgroundColor = UIColor.blue
            firstName.resignFirstResponder()
        }else if(email.text?.isEmpty)!{
            email.text = "Email ID is Missing"
            email.textColor = UIColor.red
            email.isHidden = false
            email.backgroundColor = UIColor.blue
        }else if(confirmEmail.text?.isEmpty)! {
            confirmEmail.text = "Confirm Email is Missing"
            confirmEmail.textColor = UIColor.red
            confirmEmail.isHidden = false
            confirmEmail.backgroundColor = UIColor.blue
        }else if(password.text?.isEmpty)!{
            
            password.text = "Password is Missing"
            password.textColor = UIColor.red
            password.isHidden = false
            password.backgroundColor = UIColor.blue
        }else if(confirmPassword.text?.isEmpty)! {
            confirmPassword.textColor = UIColor.red
            confirmPassword.text = "Confirm Password is Missing"
            confirmPassword.isHidden = false
            confirmPassword.backgroundColor = UIColor.blue
        }else{
            addUserData()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.firstName.text == "First Name is Missing"{
            firstName.text = ""
            firstName.textColor = UIColor.black
            firstName.backgroundColor = UIColor.white
            firstName.resignFirstResponder()
        }
        if email.text == "Email ID is Missing"{
            email.text = ""
            email.textColor = UIColor.black
            email.backgroundColor = UIColor.white
            email.resignFirstResponder()
        }
        if confirmEmail.text == "Confirm Email is Missing"{
            confirmEmail.text = ""
            confirmEmail.textColor = UIColor.black
            confirmEmail.backgroundColor = UIColor.white
            confirmEmail.resignFirstResponder()
        }
        if password.text == "Password is Missing"{
            password.isSecureTextEntry = false
            password.text = ""
            password.textColor = UIColor.black
            password.backgroundColor = UIColor.white
        }
        if confirmPassword.text == "Confirm Password is Missing"{
            confirmPassword.isSecureTextEntry = false
            confirmPassword.text = ""
            confirmPassword.textColor = UIColor.black
            confirmPassword.backgroundColor = UIColor.white
        }
       
    }
    
    func addUserData(){
        let Email = self.email.text!
        let Password = self.password.text!
        let Firstname = self.firstName.text!
        let Lastname = self.lastName.text!
        
        let url = URL(string: "https://cs.okstate.edu/~jtsutto/services.php/0/\(Email)/\(Password)/\(Firstname)/\(Lastname)")!
        print("URL: \(url)")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url){(data,response,error)in
            guard error == nil else{
                print("Error in session call: \(error)")
                return
            }
            guard let result = data else {
                print("No data reveived")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: result, options: .allowFragments) as? NSDictionary
                print("JSON data returned : \(json)")
            }catch {
                print("Error Serializing JSON data : \(error)")
            }
        }
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "MyRecipesViewController") as UIViewController
        self.present(vc, animated: true, completion: nil)
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
