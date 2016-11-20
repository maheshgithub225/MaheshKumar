//
//  RecipeDetailsViewController.swift
//  Chefulate
//
//  Created by Mahesh Kumar Kankipati on 11/20/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var recipeDetailsTableView: UITableView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var servingsize : UILabel!
    
    struct Ingedients_List{
        let I_ID: Int
        let I_Name: String
        let I_Quantity: String
        
    }
    
    var objectsArray = [Ingedients_List]()
    var filteredObjectsArray = [Ingedients_List]()
    
    var labelName : String = String()
    var serving : String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeDetailsTableView.delegate = self
        recipeDetailsTableView.dataSource = self
        recipeDetailsTableView.backgroundColor = UIColor.clear
        recipeName.text = labelName
        servingsize.text = " Serving Size: \(serving)"
        // Do any additional setup after loading the view.
    }
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
                    self.objectsArray.append(Ingedients_List(I_ID: (Int)(obj["Ingredient_ID"] as! String)!, I_Name: obj["Ingredient_Name"]! as! String,I_Quantity: obj["Amount"]! as! String))
                    
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
        return 1
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
        
        cell.backgroundColor = UIColor.clear
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
