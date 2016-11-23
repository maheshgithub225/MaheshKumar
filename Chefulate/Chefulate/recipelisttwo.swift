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
    var masterarray = [ingredient]()
    var counter = 1
    var id = 7
    var countertwo = 1
    var counterthree = 1
    var g:String = ""
    var servingsize:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countrecipes()
        
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.countertwo = 0
            
            
        }
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.selectdb()
            
            self.tableView.reloadData()
        }
        
        //  selectdb()
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
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return masterarray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(counter)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "secondcell", for: indexPath)
        if countertwo == 0 {
            
            
            //   if  indexPath[1] == 0{
            //   cell.textLabel?.text = "\(masterarray[(indexPath[1]])"
            //   }
            //  else{
            cell.textLabel?.text = "\(masterarray[indexPath[1]].ingredientdisplay())"
            cell.detailTextLabel?.text="\(masterarray[indexPath[1]].seconddisplay())"
            //  }
        }
        
        // cell.textLabel?.text = "\(masterarray[indexPath[1]])"
        //  cell.detailTextLabel?.text="\(laparray[indexPath[1]].display_time())"
        
        return cell
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
        for item in stride(from: masterarray.count - 1, through: 0, by: -1){
            
            masterarray.remove(at: item)
        }
        //run select operation
        return true
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "secondcell", for: indexPath)
        
        
        
        //checks to see if the train_car class property bool "is pressed" is checked for each row in order to highlight rows.  The color change actually occurs within cellsforrows function
        
        if  masterarray[indexPath[1]].ispressed == false {
            
            cell.backgroundColor = UIColor(red:0.6, green: 1,blue: 0.6, alpha: 1.0)
            cell.textLabel?.backgroundColor = UIColor(red:0.6, green: 1,blue: 0.6, alpha: 1.0)
            cell.detailTextLabel?.backgroundColor = UIColor(red:0.6, green: 1,blue: 0.6, alpha: 1.0)
            masterarray[indexPath[1]].ispressed = true
            kflag=1
            g = masterarray[indexPath[1]].recipe_id
            servingsize=masterarray[indexPath[1]].serving_size
            self.tableView.reloadData()
        }
            
        else if masterarray[indexPath[1]].ispressed == true{
            
            cell.backgroundColor = UIColor(red:1.0, green: 1,blue: 1.0, alpha: 1.0)
            cell.textLabel?.backgroundColor = UIColor.white
            cell.detailTextLabel?.backgroundColor = UIColor.white
            masterarray[indexPath[1]].ispressed = false
            kflag=0
            self.tableView.reloadData()
        }
        
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
        
        if countertwo == 0{
            let url = URL(string: "https://cs.okstate.edu/~rbryanm/chefselectall.php/\(id)")!
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
                    
                    
                    let json = try JSONSerialization.jsonObject(with: result, options: .allowFragments) as? Array<Any>
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
                    
                    for index in stride(from: 0, to: self.counter, by: +1) {
                        
                        var sd: String = "\(json?[index])"
                        print(sd)
                        
                        let fullNameArr = sd.characters.split{$0 == ";"}.map(String.init)
                        
                        print("\( fullNameArr[0])")
                        // var Da:[String] = fullNameArr[0].characters.split{$0 == "\""}.map(String.init)
                        var ca = fullNameArr[3].characters.split{$0 == " "}.map(String.init)
                        var ea = fullNameArr[4].characters.split{$0 == " "}.map(String.init)
                        
                        var fa = fullNameArr[5].characters.split{$0 == " "}.map(String.init)
                        var ta = fullNameArr[4].characters.split{$0 == "\""}.map(String.init)
                        print("TTTTT")
                        print("\(ta[3])")
                        print("TTTTT")
                        
                        print("TTTTT")
                        print("\(fa[3])")
                        var recipe:ingredient = ingredient(init_recipe_id: ca[3], init_ingredient: ta[3], init_serving_size: fa[3])
                        self.masterarray.append(recipe)
                        
                    }
                    
                    
                }
                    
                catch{
                    print("error serializing jon data: \(error)")
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    self.counterthree = 0
                    self.tableView.reloadData()
                    
                })
                
            }
            task.resume()
            
        }
    }
    
    func countrecipes(){
        
        let url = URL(string: "https://cs.okstate.edu/~jtsutto/services.php/7")!
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
                print("LLLL")
                print("\(json)")
                var sd:String = "\(json)"
                var Da:[String] = sd.characters.split{$0 == "\""}.map(String.init)
                print("second")
                print("\(Da[2])")
                var ca = Da[2].characters.split{$0 == " "}.map(String.init)
                print("third")
                print("\(ca[1])")
                var ea = ca[1].characters.split{$0 == ";"}.map(String.init)
                print("fourth")
                print("\(ea[0])")
                self.counter = Int(ea[0])!
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
                //   print("LLLLLLLLL")
                
                /*
                 
                 //     var sd: String = "\(json?[index])"
                 print(sd)
                 
                 let fullNameArr = sd.characters.split{$0 == ";"}.map(String.init)
                 
                 print("\( fullNameArr[0])")
                 // var Da:[String] = fullNameArr[0].characters.split{$0 == "\""}.map(String.init)
                 var ca = fullNameArr[3].characters.split{$0 == " "}.map(String.init)
                 var ea = fullNameArr[4].characters.split{$0 == " "}.map(String.init)
                 var fa = fullNameArr[5].characters.split{$0 == " "}.map(String.init)
                 print("TTTTT")
                 print("\(ca[3])")
                 print("TTTTT")
                 print("\(ea[3])")
                 print("TTTTT")
                 print("\(fa[3])")
                 //var car:train_car = train_car(init_date: Da[1], init_id: ca[3], init_car_number: ea[3], init_road: fa[3])
                 // masterarray.append(car)
                 */
                
            }
                
                
                
                
            catch{
                print("error serializing jon data: \(error)")
            }
            DispatchQueue.main.async(execute: { () -> Void in
                
                self.countertwo = 0
                self.tableView.reloadData()
                
            })
            
        }
        task.resume()
        
    }
    
    
    
    
    
    
}



