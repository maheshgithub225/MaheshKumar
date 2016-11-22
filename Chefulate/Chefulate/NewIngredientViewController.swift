//
//  NewIngredientViewController.swift
//  Chefulate
//
//  Created by Johnathan Taylor Sutton on 11/20/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class NewIngredientViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet var cTableView: UITableView!
    @IBOutlet weak var nextbutton: UIButton!
    
    var R_ID:Int = 0
    var I_ID: String = ""
    var I_Name: String = ""
    var I_Amount: String = ""
    var I_Units: String = ""
    
    struct ingredients{
        let I_ID: Int
        let I_Name: String
        let I_Amount: Int
        let I_Unit: String
    }
    
    struct ingDB {
        let I_ID: Int
        let I_Name: String
    }
    
    struct ingRP{
        let I_ID: Int
        let I_Quant: Int
        let I_Unit: String
    }
    
    var data_array = [ingredients]()
    var ingDB_array = [ingDB]()
    var ingRP_array = [ingRP]()
    
    var radius : Int = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        print( "RID = \(R_ID)")
        cTableView.delegate = self
        cTableView.dataSource = self
        cTableView.backgroundColor = UIColor.clear
        nextbutton.layer.cornerRadius = CGFloat(radius)
        downloadIngredientsList()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "AddIngredient"){
            let vc = segue.destination as! AddIngredients
            vc.R_ID = R_ID
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! SearchRecipeTableViewCell
        
        let row = indexPath.row
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "recipeDetailsView", sender: self)
    }
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        let row = indexPath.row
        print(data_array[row])
    }
    
    @IBAction func unwindToIng(segue: UIStoryboardSegue) {
        self.downloadIngredientsFromRecipe()
    }
    
    
    
    func downloadIngredientsFromRecipe(){
        let urlString = "https://cs.okstate.edu/~jtsutto/services.php/19/\(R_ID)"
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
                let jsonResult = try JSONSerialization.jsonObject(with: result, options: .allowFragments) as? NSDictionary
                print("JSON delete data returned : \(jsonResult)")
                print("Count: \(jsonResult?.count)")
                if(jsonResult != nil){
                    for x in (1...(Int)((jsonResult?.count)!)){
                        let obj = jsonResult?["\(x)"] as! NSDictionary
                        self.ingRP_array.append(ingRP(I_ID: (Int)(obj["Ingredient_ID"] as! String)!, I_Quant: (Int)(obj["Quantity"] as! String)!, I_Unit: obj["Ingredient_Measurement"] as! String))
                    
                    }
                }
                self.cTableView.dataSource = self
            }catch {
                print("Error Serializing JSON data : \(error)")
            }
            DispatchQueue.main.async {
                self.populateData()
            }
        }
        task.resume()
    }
    
    func downloadIngredientsList(){
        let urlString = "https://cs.okstate.edu/~jtsutto/services.php/16"
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
                
                for x in (1...(Int)((json?.count)!)){
                    let obj = json?["\(x)"] as! NSDictionary
                    self.ingDB_array.append(ingDB(I_ID: (Int)(obj["Ingredient_ID"] as! String)!, I_Name: obj["Ingredient_Name"] as! String))
                }
                print(self.ingDB_array)
    
                
                print("JSON delete data returned : \(json)")
            }catch {
                print("Error Serializing JSON data : \(error)")
            }
            DispatchQueue.main.async {
                self.downloadIngredientsFromRecipe()
            }
        }
        task.resume() 
    }
    
    func populateData(){
        print("RP COUNT \(ingRP_array.count)")
        print("Table DB Data: \(ingDB_array)")
        print("Table RP Data: \(ingRP_array)")
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
