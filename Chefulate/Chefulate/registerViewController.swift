//  registerViewController.swift
//  Chefulate
//  Created by Bryan Reynolds on 10/17/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.


import UIKit
import Foundation

class registerViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var confirmEmail: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func signUpButton(_ sender: AnyObject) {
        addUserData()
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
