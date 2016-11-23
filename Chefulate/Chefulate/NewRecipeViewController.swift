//
//  NewRecipeViewController.swift
//  Chefulate
//
//  Created by Mahesh Kumar Kankipati on 11/14/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit
import Foundation

class NewRecipeViewController: UIViewController{
    @IBOutlet weak var RecipeTitle: UITextField!
    @IBOutlet weak var servingSize: UITextField!
    var radius : Int = Int()
    
    @IBOutlet weak var homeButton: UIButton!
    var UID: Int = 0
    var U_Full: String = ""
    var R_ID: Int = 0
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeButton.layer.cornerRadius = homeButton.frame.width/2
    }
    
    @IBAction func unwindToNewRecipe(segue: UIStoryboardSegue){
        print("Test un")
        deleteRecipe()
    }
    
    
    @IBAction func unwindToNewRecipeFromInstView(segue: UIStoryboardSegue){}
    
    
    @IBAction func submitRecipe(_ sender: AnyObject) {
        let alertControl = UIAlertController(title: "Are you sure?", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .destructive){
            (result : UIAlertAction) in debugPrint("Add")
        }
        let save = UIAlertAction(title: "Save", style: .destructive) { (_) -> Void in
            self.addRecipeData()
        }
        alertControl.addAction(save)
        alertControl.addAction(cancel)
        self.present(alertControl, animated: true, completion: nil)
    }
    
    
    func addRecipeData(){
        let S_Size = servingSize.text!
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date_formatted = formatter.string(from: date)
        let urlString = "https://cs.okstate.edu/~jtsutto/services.php/5/\(R_ID)/\(U_Full)/\(UID)/\(date_formatted)/\(S_Size)"
        let urlString_Fixed = urlString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        let url = URL(string: urlString_Fixed! )!
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
                print("JSON test data returned : \(json)")
                DispatchQueue.main.async{
                    self.getID()
                }
            }catch {
                print("Error Serializing JSON data : \(error)")
            }
            
            
        }
        task.resume()
    }
    
    func getID(){
        let urlString = "https://cs.okstate.edu/~jtsutto/services.php/18/\(UID)"
        let urlString_Fixed = urlString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        let url = URL(string: urlString_Fixed! )!
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
                print("JSON test data returned : \(json)")
                self.R_ID = (Int)(json!["Recipie_ID"] as! String)!
            }catch {
                print("Error Serializing JSON data : \(error)")
            }
            DispatchQueue.main.async {
                let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let vc = mainStoryboard.instantiateViewController(withIdentifier: "NewIng") as! NewIngredientViewController
                vc.R_ID = self.R_ID
                self.present(vc, animated: true, completion: nil)
                
            }
        }
        task.resume()
    }
    
    func deleteRecipe(){
        let urlString = "https://cs.okstate.edu/~jtsutto/services.php/9/\(R_ID)"
        let urlString_Fixed = urlString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        let url = URL(string: urlString_Fixed! )!
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
                print("JSON delete data returned : \(json)")
            }catch {
                print("Error Serializing JSON data : \(error)")
            }
        }
        task.resume()
    }
    
    
    
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewRecipeViewController.dismissKeyboard))
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
