//
//  NewRecipeViewController.swift
//  Chefulate
//
//  Created by Mahesh Kumar Kankipati on 11/14/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit
import Foundation

class NewRecipeViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var RecipeTitle: UITextField!
    @IBOutlet weak var tableViewCustom1: UITableView!
    @IBOutlet weak var servingSize: UITextField!
    @IBOutlet weak var ingredientCell: UITableViewCell!
    
    var ingName : String = String()
    var quantity : String = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewCustom1.delegate = self
        tableViewCustom1.dataSource = self
        self.tableViewCustom1.backgroundColor = UIColor.clear
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
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowcount = 0
        if section == 0{
            rowcount = 2
        }
        if section == 1 {
            rowcount = 2
        }
        return rowcount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientcell", for: indexPath as IndexPath)
        cell.textLabel?.text = ingName
        cell.detailTextLabel?.text = quantity
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
    
    
    func addRecipeData(){
        let NewRecipeTitle = RecipeTitle.text!
        
        let url = URL(string: "https://cs.okstate.edu/~jtsutto/services.php/0/\(NewRecipeTitle)")!
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
