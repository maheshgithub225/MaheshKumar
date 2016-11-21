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

    
    var UID: Int = 0
    var U_Full: String = ""
    
    struct instructions{
        let I_ID: Int
        let I_Data: String
    }

    var ins_data = [instructions]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func unwindToNewRecipe(segue: UIStoryboardSegue){}
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
        let R_Name = RecipeTitle.text!
        let S_Size = servingSize.text!
        let tDateF = NSDate()
        let cal = NSCalendar.current
        let comp = cal.dateComponents([.year,.day,.month], from: tDateF as Date)
        var month: String = "\(comp.month!)"
        var day: String = "\(comp.day!)"
        if(comp.month! < 10){
            month = "0\(comp.month!)"
        }
        if(comp.day! < 10){
            day = "0\(comp.day!)"
        }
        let date = "\(comp.year!)-\(month)-\(day)"
        let url = URL(string: "https://cs.okstate.edu/~jtsutto/services.php/5/\(R_Name)/\(U_Full)/\(UID)/\(date)/\(S_Size)")!
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
            }catch {
                print("Error Serializing JSON data : \(error)")
            }
            DispatchQueue.main.async{
                //self.performSegue(withIdentifier: "guestUser", sender: nil)
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
