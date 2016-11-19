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
    
    struct recipes{
        let C_ID: Int
        let R_ID: Int
        let R_Name: String
        let C_Name: String
        let S_Size: Int
        let C_Date: String
    }
    
    var objectsArray = [recipes]()
    var filteredObjectsArray = [recipes]()
    
    var recipes: NSDictionary = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewCustom.delegate = self
        TableViewCustom.dataSource = nil
        downloadData()
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
                    print("Object \(x): \(obj["Recipie_Name"]!)")
                    self.objectsArray.append(recipes(C_ID: (Int)(obj["Creator_ID"] as! String)!, R_ID: (Int)(obj["Recipie_ID"] as! String)!, R_Name: obj["Recipie_Name"]! as! String, C_Name: obj["Creator_Full_Name"]! as! String, S_Size: (Int)(obj["Serving_Size"] as! String)!, C_Date: obj["Creation_Date"]! as! String))

                }
                print(self.objectsArray)
                self.TableViewCustom.dataSource = self
                DispatchQueue.main.async {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = objectsArray[row].R_Name
        
        return cell
    }
    
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        let row = indexPath.row
        print(objectsArray[row])
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