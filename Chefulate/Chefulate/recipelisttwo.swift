//
//  recipelisttwo.swift
//  Chefulate
//
//  Created by Jayme Crosby on 11/13/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class recipelisttwo: UITableViewController {
var kflag=0
    var counter = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        selectdb()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    func alert(){
        
        
        
        
        let alertController = UIAlertController(title: "cannot save",message: "please select a recipe",preferredStyle: .alert)
        let cancelaction=UIAlertAction(title:"cancel",style:.default){(result:UIAlertAction)  in debugPrint("cancel")
        }
        
        
        alertController.addAction(cancelaction)
        self.present(alertController,animated:true,completion: nil)
        
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: (String!), sender: Any!) -> Bool{
        if kflag == 0{
            alert()
        return false
        }
        
        //run select operation
        return true
        
    }
    
   
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
    func selectdb(){
       
        
        let url = URL(string: "https://cs.okstate.edu/~jtsutto/services.php/2")!
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url){(data,response,error)in
            guard error == nil else{
                print("error in session call:\(error)")
                return
            }
            guard let result = data else{
                print("no data received")
                return
            }
            do{
                
                
                let json = try JSONSerialization.jsonObject(with: result, options: .allowFragments) as? NSDictionary
                /*
                for index in stride(from: 0, to: self.counter, by: +1) {
                    print("TTTTTTT")
                    var sd: String = "\(json?[index])"
                    print(sd)
                    
                    let fullNameArr = sd.characters.split{$0 == ";"}.map(String.init)
                    
                    print(fullNameArr[0])
                 //   var Da:[String] = fullNameArr[0].characters.split{$0 == "\""}.map(String.init)
                 //   var ca = fullNameArr[1].characters.split{$0 == " "}.map(String.init)
                 //   var ea = fullNameArr[2].characters.split{$0 == " "}.map(String.init)
                 //   var fa = fullNameArr[3].characters.split{$0 == " "}.map(String.init)
                    
                  //  var recipe:recipe_ingredient = recipe_ingredient(init_ingredient: Da[1], init_measurement: ca[3], init_quantity: ea[3])
                  //  masterarray.append(car)
                    
                }
                */
                print("LLLLLLLLL")
                var devices = json?.object(forKey: "Recipie_ID") as! Array<Any>
                
                
                        print("\(devices[0])")
                
                
                
            }
                
            catch{
                print("error serializing jon data: \(error)")
            }
            DispatchQueue.main.async(execute: { () -> Void in
                
                self.counter = 0
                self.tableView.reloadData()
                
            })
            
        }
        task.resume()
        
    }
    


}
