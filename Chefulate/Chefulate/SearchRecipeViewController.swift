//
//  SearchRecipeViewController.swift
//  Chefulate
//
//  Created by Johnathan Taylor Sutton on 11/18/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class SearchRecipeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var TableViewCustom: UITableView!
    
    @IBOutlet weak var homebutton: UIButton!
    struct recipes{
        let C_ID: Int
        let R_ID: Int
        let R_Name: String
        let C_Name: String
        let S_Size: Int
        let C_Date: String
    }
    var radius : Int = Int()
    var objectsArray = [recipes]()
    var filteredObjectsArray = [recipes]()
    
    var recipeName : String = String()
    var servingsize : String = String()
    
    var recipes: NSDictionary = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewCustom.delegate = self
        TableViewCustom.dataSource = nil
        downloadData()
        TableViewCustom.backgroundColor = UIColor.clear
        radius = 15
        homebutton.layer.cornerRadius = CGFloat(radius)
        // Do any additional setup after loading the view.
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Tasks
    func downloadData(){
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
                    self.objectsArray.append(recipes(C_ID: (Int)(obj["Creator_ID"] as! String)!, R_ID: (Int)(obj["Recipie_ID"] as! String)!, R_Name: obj["Recipie_Name"]! as! String, C_Name: obj["Creator_Full_Name"]! as! String, S_Size: (Int)(obj["Serving_Size"] as! String)!, C_Date: obj["Creation_Date"]! as! String))

                }
                self.TableViewCustom.dataSource = self
                DispatchQueue.main.async{
                    self.TableViewCustom.reloadData()
                }
            }catch{
                print("Error seralizing JSON Data: \(error)")
            }
            

        })
        task.resume()
        
    }
    

    
    
    
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! SearchRecipeTableViewCell
        
        let row = indexPath.row

        cell.R_name!.text = objectsArray[row].R_Name
        cell.C_Name!.text = "By: \(objectsArray[row].C_Name)"
        cell.Date!.text = objectsArray[row].C_Date
        cell.S_Size!.text = "Serves: \(objectsArray[row].S_Size)"
        cell.R_name!.textColor = UIColor.white
        cell.C_Name!.textColor = UIColor.white
        cell.Date!.textColor = UIColor.white
        cell.S_Size!.textColor = UIColor.white
        recipeName = cell.R_name!.text! as String
        servingsize = "\(objectsArray[row].S_Size)"
        cell.backgroundColor = UIColor.clear
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "recipeDetailsView", sender: self)
    }
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        let row = indexPath.row
        print(objectsArray[row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.identifier == "recipeDetailsView"{
            let recipeDetailsView = segue.destination as! RecipeDetailsViewController
            recipeDetailsView.labelName = recipeName
            recipeDetailsView.serving = servingsize
        }

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindRecipeList(segue: UIStoryboardSegue){}

}
