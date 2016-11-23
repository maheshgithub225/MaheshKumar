//
//  RecipeDetailsInstructionsViewController.swift
//  Chefulate
//
//  Created by Mahesh Kumar Kankipati on 11/22/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class RecipeDetailsInstructionsViewController: UIViewController,  UITextViewDelegate{

    @IBOutlet weak var textScrollView: UITextView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var instructionCount: UILabel!
    @IBOutlet weak var servingSize: UILabel!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var instructionsTableView: UITableView!
    var radius : Int = Int()
    
    var recipeID : Int = Int()
    
    struct Instructions_List{
        let R_ID : Int
        let In_ID: Int
        let In_Name: String
    }
    var instructionsArray = [Instructions_List]()
    override func viewDidLoad() {
        super.viewDidLoad()
        radius = 15
        //instructionsTableView.delegate = self
        //instructionsTableView.dataSource = self
        textScrollView.delegate = self
        backButton.layer.cornerRadius = CGFloat(radius)
        downloadInstructions()
        
        
        textScrollView.backgroundColor = UIColor.clear
        
        
        // Do any additional setup after loading the view.
    }
    func downloadInstructions(){
        let urlString = "https://cs.okstate.edu/~jtsutto/services.php/20/\(recipeID)"
        let urlString_Fixed = urlString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        let url = URL(string: urlString_Fixed! )!
        print("URL: \(url)")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with:url, completionHandler: {(data, response, error) in
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
                let jsonResult = try(JSONSerialization.jsonObject(with: result, options: .allowFragments) as? NSDictionary)
                print("JSON data returned: \(jsonResult)")
                print("Count: \(jsonResult?.count)")
                 if(jsonResult?.count != nil){
                for x in (1...(Int)((jsonResult?.count)!)){
                    let obj = jsonResult?["\(x)"] as! NSDictionary
                    self.instructionsArray.append(Instructions_List(R_ID: (Int)(obj["Recipie_ID"] as! String)!,In_ID: (Int)(obj["Sequence_ID"] as! String)!, In_Name: obj["Instruction"]! as! String))
                     
                    }
                }
            }catch{
                print("Error seralizing JSON Data: \(error)")
            }
           
            DispatchQueue.main.async {
                self.instruct()
            }
        })
        task.resume()
        
    }
    
    func instruct(){
        var ins : String = String()
        for x in instructionsArray{
            ins.append("\(x.In_ID). \(x.In_Name)" + "\n\n")
        }
        textScrollView.text = ins
        
    }
    
    
    
    @IBAction func backButtonTouched(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "toRecipeDetails", sender: self)
    }
    
    
    
//    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return instructionsArray.count
//    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Instructions"
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 30
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
//       // let row = indexPath.row
//       // cell.textLabel?.text = String(instructionsArray[row].In_ID)
//        //cell.detailTextLabel?.text = "\(instructionsArray[row].In_Name)"
//            cell.backgroundColor = UIColor.clear
//    
//        return cell
//    }


}
