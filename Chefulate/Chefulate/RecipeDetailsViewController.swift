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

    @IBOutlet weak var recipeDetailsTableView: UITableView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var servingsize : UILabel!
    var radius : Int = Int()
    struct Ingedients_List{
        let I_ID: Int
        let I_Name: String
        let I_Amount: Int
        let I_Units : String
        
    }
    struct Instructions_List{
        let In_ID: Int
        let In_Name: String
    }
    var objectsArray = [Ingedients_List]()
    var filteredObjectsArray = [Ingedients_List]()
    
    var instructionsArray = [Instructions_List]()
    
    var labelName : String = String()
    var serving : String = String()
    override func viewWillAppear(_ animated: Bool) {
        downloadIngredients()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeDetailsTableView.delegate = self
        recipeDetailsTableView.dataSource = self
        recipeDetailsTableView.backgroundColor = UIColor.clear
        recipeName.text = labelName
        servingsize.text = "Serving Size: \(serving)"
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        // Do any additional setup after loading the view.
    }
    func downloadIngredients(){
        let url_download_data = URL(string: "https://cs.okstate.edu/~jtsutto/services.php/")!
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
            
            do{
                let jsonResult = try(JSONSerialization.jsonObject(with: result, options: .allowFragments) as! NSDictionary)
                print("JSON data returned: \(jsonResult)")
                print("Count: \(jsonResult.count)")
                for x in (1...jsonResult.count){
                    let obj = jsonResult["\(x)"] as! NSDictionary
                    self.objectsArray.append(Ingedients_List(I_ID: (Int)(obj["Ingredient_ID"] as! String)!, I_Name: obj["Ingredient_Name"]! as! String,I_Amount: (Int)(obj["Amount"]! as! String)!, I_Units: obj["Units"]! as! String))
                    
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
    func downloadInstructions(){
        let url_download_data = URL(string: "https://cs.okstate.edu/~jtsutto/services.php/2")!
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
            
            do{
                let jsonResult = try(JSONSerialization.jsonObject(with: result, options: .allowFragments) as! NSDictionary)
                print("JSON data returned: \(jsonResult)")
                print("Count: \(jsonResult.count)")
                for x in (1...jsonResult.count){
                    let obj = jsonResult["\(x)"] as! NSDictionary
                    self.instructionsArray.append(Instructions_List(In_ID: (Int)(obj["Instruction_ID"] as! String)!, In_Name: obj["Instruction_Name"]! as! String))
                    
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
            rows = objectsArray.count
        }
        if section == 1 {
            rows = instructionsArray.count
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var title : String = String()
        if section == 0 {
            title = "Ingedients"
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
        if sec == 0 {
            cell.textLabel?.text = objectsArray[row].I_Name
            cell.detailTextLabel?.text = "\(objectsArray[row].I_Amount) \(objectsArray[row].I_Units)"
            cell.backgroundColor = UIColor.clear
        }
        if sec == 1 {
            cell.textLabel?.text = objectsArray[row].I_Name
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
