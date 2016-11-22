//
//  IngredientsTableViewController.swift
//  Chefulate
//
//  Created by Mahesh Kumar Kankipati on 11/17/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class IngredientsTableViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var json : NSDictionary  = NSDictionary()
    var ingredients : NSDictionary = NSDictionary()
    
    @IBOutlet weak var backbutton: UIButton!
    @IBOutlet weak var selectbutton: UIButton!
    @IBOutlet weak var ingredientsTableView: UITableView!
    var radius : Int = Int()
    var I_ID: Int = Int()
    
    struct ingredients_list{
        let I_ID: Int
        let I_Name: String
        let W_Price: Double
        let W_Measure: String
    }
    
    var data_array = [ingredients_list]()
    var flag = Bool()
    var mutableDic : NSMutableDictionary  = NSMutableDictionary()
    let backgrogundimage = UIImageView(image: #imageLiteral(resourceName: "ingredientsblur.jpg"))
    var values : NSArray = []
    var mutableValues : NSMutableArray = []
    var selectedIngredient : String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        self.ingredientsTableView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        radius = 15
        selectbutton.layer.cornerRadius = CGFloat(radius)
        backbutton.layer.cornerRadius = CGFloat(radius)

        getIngredients()
        
    }
    func getIngredients() {
        let url = URL(string: "https://cs.okstate.edu/~jtsutto/services.php/16/")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url!){(data,response,error) in
            guard  error == nil else {
                print("Error in session call \(error)")
                return
            }
            guard let result = data else {
                print("No data received")
                return
            }
            do {
                self.json = try JSONSerialization.jsonObject(with: result, options: .allowFragments)as! NSDictionary
                print("JSON data returned = \(self.json)")
                self.ingredients = self.json
                
                print("\(self.ingredients)")
                for x in (1...self.json.count){
                    let obj = self.json["\(x)"] as! NSDictionary
                    self.data_array.append(ingredients_list(I_ID: (Int)(obj["Ingredient_ID"] as! String)!, I_Name: obj["Ingredient_Name"] as! String, W_Price: (Double)(obj["Walmart_Price"] as! String)!, W_Measure: obj["Walmart_Measure"] as! String))
                }
                DispatchQueue.main.async {
                    self.ingredientsTableView.reloadData()
                }
                print("Table: \(self.data_array)")
            }catch {
                print("Error serializing JSON data : \(error)")
            }
        }
        task.resume()
    }

        // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return json.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Configure the cell...*/
        cell.textLabel?.text = data_array[indexPath.row].I_Name
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        I_ID = data_array[indexPath.row].I_ID
        print(I_ID)
    }
    @IBAction func SelectIngred(_ sender: AnyObject) {
        let indexpath1 = ingredientsTableView.indexPathForSelectedRow
        let currentCell = ingredientsTableView.cellForRow(at: indexpath1!)
        selectedIngredient = (currentCell?.textLabel?.text)!
        
        
        performSegue(withIdentifier: "backToAddIngredientUnwindWithSegue", sender: self)

    }
    @IBAction func back(_ sender: AnyObject) {
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToAddIngredientUnwindWithSegue"{
            let addingredview = segue.destination as! AddIngredients
            addingredview.value = selectedIngredient
            addingredview.I_Name = selectedIngredient
            addingredview.I_ID = I_ID
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
