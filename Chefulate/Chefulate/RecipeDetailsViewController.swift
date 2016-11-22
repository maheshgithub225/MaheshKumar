//
//  RecipeDetailsViewController.swift
//  Chefulate
//
//  Created by Mahesh Kumar Kankipati on 11/20/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var backToMyRecipes: UIButton!
    @IBOutlet weak var backToSearchRecipes: UIButton!
    @IBOutlet weak var recipeDetailsTableView: UITableView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var servingsize : UILabel!
    var radius : Int = Int()
    
    var detailsSegueIdentifier : String = String()
    
    var recipeID : Int = Int()
    struct Ingedients_List{
        let I_ID: Int
        let I_Name: Int
        let I_Amount: Int
        let Re_ID : Int
        let I_Units : String
    }
    struct ingRP{
        let I_ID: Int
        let RI_ID: Int
        let I_Quant: Int
        let I_Unit: String
    }
    struct ingDB {
        let I_ID: Int
        let I_Name: String
    }
    struct Instructions_List{
        let R_ID : Int
        let In_ID: Int
        let In_Name: String
    }
    var objectsArray = [Ingedients_List]()
    var filteredObjectsArray = [Ingedients_List]()
    var ingRP_array = [ingRP]()
    var ingDB_array = [ingDB]()
    
    var instructionsArray = [Instructions_List]()
    
    var labelName : String = String()
    var serving : String = String()
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeDetailsTableView.delegate = self
        recipeDetailsTableView.dataSource = self
        recipeDetailsTableView.backgroundColor = UIColor.clear
        recipeName.text = labelName
        if detailsSegueIdentifier == "recipeDetailsView"{
            backToMyRecipes.isHidden = true
            backToSearchRecipes.isHidden = false
        } else if detailsSegueIdentifier == "recipeDetailsMyRecipe" {
            backToSearchRecipes.isHidden = true
            backToMyRecipes.isHidden = false
        }
        radius = 15
        backToSearchRecipes.layer.cornerRadius = CGFloat(radius)
        backToMyRecipes.layer.cornerRadius = CGFloat(radius)
        servingsize.text = "Serving Size: \(serving)"
        ingredcount.text = ""
        downloadIngredientsFromRecipe()
        downloadIngredientsList()
        // Do any additional setup after loading the view.
    }
    
    func downloadIngredientsFromRecipe(){
        let urlString = "https://cs.okstate.edu/~jtsutto/services.php/19/\(recipeID)"
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
                print("RID RP: \(self.recipeID)")
                if(jsonResult?.count != nil){
                    for x in (1...(Int)((jsonResult?.count)!)){
                        let obj = jsonResult?["\(x)"] as! NSDictionary
                        self.ingRP_array.append(ingRP(I_ID: (Int)(obj["Ingredient_ID"] as! String)!, RI_ID: (Int)(obj["RI_ID"] as! String)!, I_Quant: (Int)(obj["Quantity"] as! String)!, I_Unit: obj["Ingredient_Measurement"] as! String))
                        
                    }
                }
            }catch {
                print("Error Serializing JSON data : \(error)")
            }
            DispatchQueue.main.async {
                self.recipeDetailsTableView.reloadData()
                // self.populateData()
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
                    self.ingDB_array.append(ingDB(I_ID: (Int)(obj["Ingredient_ID"] as! String)!,I_Name: obj["Ingredient_Name"] as! String))
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
    @IBOutlet weak var ingredcount: UILabel!
    
    func downloadInstructions(){
        let url_download_data = URL(string: "https://cs.okstate.edu/~jtsutto/services.php/10/\(recipeID)")!
        let url_request = URLRequest(url: url_download_data)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with:url_request, completionHandler: {(data, response, error) in
            guard error == nil else{
                print("Error in session call: \(error)")
                return
            }
            
            guard let result = data else{
                print("No data recieved")
                return
            }
            print(response)
            do{
                let jsonResult = try(JSONSerialization.jsonObject(with: result, options: .allowFragments) as! NSDictionary)
                print("JSON data returned: \(jsonResult)")
                print("Count: \(jsonResult.count)")
                for x in (1...jsonResult.count){
                    let obj = jsonResult["\(x)"] as! NSDictionary
                    self.instructionsArray.append(Instructions_List(R_ID: (Int)(obj["Recipe_ID"] as! String)!,In_ID: (Int)(obj["Sequence_ID"] as! String)!, In_Name: obj["Instruction"]! as! String))
                    
                }
                self.recipeDetailsTableView.dataSource = self
                DispatchQueue.main.async{
                    self.recipeDetailsTableView.reloadData()
                }
            }catch{
                print("Error seralizing JSON Data: \(error)")
            }
        })
        task.resume()
    }
    
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows : Int = Int()
        if section == 0 {
            rows = ingRP_array.count
            if ingRP_array.count == 0{
                ingredcount.text! = "No Ingredients Found"
            } else {
                ingredcount.text! = ""
            }
            
        }
        if section == 1 {
            rows = instructionsArray.count
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var title : String = String()
        if section == 0 {
            title = "Ingredients"
        }
        if section == 1 {
            title = "Instructions"
        }
        return title
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        let sec = indexPath.section
        let row = indexPath.row
        var name = ""
        if sec == 0 {
            for x in ingDB_array{
                if(x.I_ID == ingRP_array[indexPath.row].I_ID){
                    name = x.I_Name
                }
            }
            cell.textLabel?.text = "\(name)"
            cell.detailTextLabel?.text = "\(ingRP_array[indexPath.row].I_Quant) \(ingRP_array[indexPath.row].I_Unit)"
            cell.backgroundColor = UIColor.clear
        }
        if sec == 1 {
            cell.textLabel?.text = String(instructionsArray[row].In_ID)
            cell.detailTextLabel?.text = "\(instructionsArray[row].In_ID) \(instructionsArray[row].In_Name)"
            cell.backgroundColor = UIColor.clear
        }
        
        return cell
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
