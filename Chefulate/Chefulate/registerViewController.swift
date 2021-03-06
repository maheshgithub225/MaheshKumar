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
    @IBOutlet weak var signupbutton: UIButton!
    @IBOutlet weak var cancelbutton: UIButton!
    
    var radius : Int = Int()
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        radius = 15
        firstName.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
        email.delegate = self
        confirmEmail.delegate = self
        signupbutton.layer.cornerRadius = CGFloat(radius)
        cancelbutton.layer.cornerRadius = CGFloat(radius)
    }
    @IBAction func signUpButton(_ sender: AnyObject) {
        if(firstName.text?.isEmpty)!{
            firstName.text = "First Name is Missing"
            firstName.textColor = UIColor.red
            firstName.isHidden = false
            firstName.backgroundColor = UIColor.white
            firstName.resignFirstResponder()
        }else if(email.text?.isEmpty)!{
            email.text = "Email ID is Missing"
            email.textColor = UIColor.red
            email.isHidden = false
            email.backgroundColor = UIColor.white
        }else if confirmEmail.text != email.text {
            confirmEmail.text = "Email do not match"
            confirmEmail.textColor = UIColor.red
            confirmEmail.isHidden = false
            confirmEmail.backgroundColor = UIColor.white
        }else if(password.text?.isEmpty)!{
            password.isSecureTextEntry = false
            password.text = "Password is Missing"
            password.textColor = UIColor.red
            password.isHidden = false
            password.backgroundColor = UIColor.white
        }else if confirmPassword.text != password.text {
            confirmPassword.isSecureTextEntry = false
            confirmPassword.textColor = UIColor.red
            confirmPassword.text = "Passwords do not match"
            confirmPassword.isHidden = false
            confirmPassword.backgroundColor = UIColor.white
        }else{
            let alert = UIAlertController(title: "Accept Terms of Service", message: "By clicking Accept you agree to abide by the Terms of Use.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Accept", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in self.addUserData()}))
            alert.addAction(UIAlertAction(title: "Decline", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if email.text == "Email ID is Missing"{
            email.text = ""
            email.textColor = UIColor.black
            email.backgroundColor = UIColor(white: 1, alpha: 0.72)
        }
        if firstName.text == "First Name is Missing"{
            firstName.text = ""
            firstName.textColor = UIColor.black
            firstName.backgroundColor = UIColor(white: 1, alpha: 0.72)
        }
        if confirmEmail.text == "Email do not match"{
            confirmEmail.text = ""
            confirmEmail.textColor = UIColor.black
            confirmEmail.backgroundColor = UIColor(white: 1, alpha: 0.72)
            confirmEmail.resignFirstResponder()
        }
        if password.text == "Password is Missing"{
            password.text = ""
            password.textColor = UIColor.black
            password.backgroundColor = UIColor(white: 1, alpha: 0.72)
            password.isSecureTextEntry = true
        }
        if confirmPassword.text == "Passwords do not match"{
            confirmPassword.text = ""
            confirmPassword.textColor = UIColor.black
            confirmPassword.backgroundColor = UIColor(white: 1, alpha: 0.72)
            confirmPassword.isSecureTextEntry = true
        }
        
    }
    
    func addUserData(){
        let Email = self.email.text!
        let Password = self.password.text!
        let Firstname = self.firstName.text!
        let Lastname = self.lastName.text!
        
        let url = "https://cs.okstate.edu/~jtsutto/services.php/0/\(Email)/\(Firstname)/\(Lastname)/\(Password)"
        let urlString_Fixed = url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        let urlS = URL(string: urlString_Fixed! )!
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlS){(data,response,error)in
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
        let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "LogInViewController") as UIViewController
        self.present(vc, animated: true, completion: nil)
        task.resume()
    }
    
    
    
    @IBAction func cancelButtonPushed(_ sender: AnyObject) {
    }
    
    
    @IBAction func unwindToRegistration(segue: UIStoryboardSegue) {}
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        email.resignFirstResponder()
        password.resignFirstResponder()
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
        confirmEmail.resignFirstResponder()
        confirmPassword.resignFirstResponder()
        return true
    }

    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(registerViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
