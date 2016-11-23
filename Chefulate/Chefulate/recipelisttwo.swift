//
//  recipelisttwo.swift
//  Chefulate
//
//  Created by Bryan Reynolds on 11/13/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//








import UIKit








class recipelisttwo: UITableViewController {
    @IBOutlet weak var navbar: UINavigationBar!
    var kflag=0    //switch variable, turned to 1 to let controller know its okay to save, to avoid error
    var masterarray = [ingredient]()
    var counter = 0  //stores counts recipes, thisvariable is changed later on.
    var id = 7      //this needs store the user id from the login screen. right now its a dummy variable
    var countertwo = 1   //helps with json
    var counterthree = 1  //helps with json
    var g:String = ""  //stores recipeid
    var kflagtwo = 1  //helps with syncing of json
    var kflagfive = 0
    var servingsize:String = ""  //stores serving size
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //To Teamred: Change this to your desired height. the more it is the lower the navbar.
        navbar.frame.size.height = 100
        navbar.isTranslucent = true
        
        navbar.backgroundColor = UIColor(red:1.0, green: 0,blue: 0.0, alpha: 1.0)
        self.countrecipes()
        
        
        
        let when = DispatchTime.now() + 4
        DispatchQueue.main.asyncAfter(deadline: when) {
            if self.counter != 0{
                self.selectdb()
            }
            self.kflagfive = 1
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if kflagtwo == 0{
            return masterarray.count
        }
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(counter)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "secondcell", for: indexPath)
        if kflagtwo == 0 {
            
            cell.textLabel?.text = "\(masterarray[indexPath[1]].ingredientdisplay())"
            cell.detailTextLabel?.text="\(masterarray[indexPath[1]].seconddisplay())"
            
            if masterarray[indexPath[1]].ispressed == true{
                cell.backgroundColor = UIColor(red:0.5, green: 0,blue: 0.0, alpha: 1.0)
                cell.textLabel?.backgroundColor = UIColor(red:0.5, green: 0,blue: 0, alpha: 1.0)
                cell.detailTextLabel?.backgroundColor = UIColor(red:0.5, green: 0,blue: 0, alpha: 1.0)
            }
            else{
                cell.backgroundColor = UIColor(red:1.0, green: 1,blue: 1.0, alpha: 1.0)
                cell.textLabel?.backgroundColor = UIColor(red:1.0, green: 1,blue: 1.0, alpha: 1.0)
                cell.detailTextLabel?.backgroundColor = UIColor(red:1.0, green: 1,blue: 1.0, alpha: 1.0)
            }
            
        }
        else if masterarray.count == 0 && kflagtwo == 0{
            
            cell.textLabel?.text = "no recipes created by user"
            cell.detailTextLabel?.text = "try adding a recipe"
        }
        else {
            cell.textLabel?.text = "please wait.."
            cell.detailTextLabel?.text = " "
        }
        
        
        return cell
    }
    /*
     alert function and alerttwo function bring alert controllers in save and go back button and cancel button to guarantee these do not provide issues
     
     */
    
    func alert(){
        
        
        let alertController = UIAlertController(title: "cannot save",message: "please select a recipe",preferredStyle: .alert)
        let cancelaction=UIAlertAction(title:"cancel",style:.default){(result:UIAlertAction)  in debugPrint("cancel")
        }
        
        
        alertController.addAction(cancelaction)
        self.present(alertController,animated:true,completion: nil)
        
    }
    func alerttwo(){
        
        
        
        let alertController = UIAlertController(title: "please wait",message: "until finished loading",preferredStyle: .alert)
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
        kflagtwo = 0
        
        return true
        
        
    }
    
    /*
     cancel action button
     
     */
    @IBAction func cancelaction(_ sender: UIBarButtonItem) {
        
        
        if kflagtwo == 0 || kflagfive == 1{
            performSegue(withIdentifier: "segue", sender: nil)
        }
        else {
            alerttwo()
        }
        
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.dequeueReusableCell(withIdentifier: "secondcell", for: indexPath)
        if kflagtwo == 0{
            for index in stride(from: 0, to: self.counter, by: +1) {
                masterarray[index].ispressed=false
                
            }
            
            
            masterarray[indexPath[1]].ispressed = true
            kflag=1
            g = masterarray[indexPath[1]].recipe_id
            servingsize=masterarray[indexPath[1]].serving_size
            self.tableView.reloadData()
            
            
        }
        self.tableView.reloadData()
        
        
    }
    
    /*
     uses a select sql statement to bring in all the recipes and parses it
     
     */
    
    func selectdb(){
        if counter != 0{
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
                        
                        
                        
                        for index in stride(from: 0, to: self.counter, by: +1) {
                            print("counter")
                            print(self.counter)
                            
                            var sd: String = "\(json?[index])"
                            print(sd)
                            
                            let fullNameArr = sd.characters.split{$0 == ";"}.map(String.init)
                            
                            print("\( fullNameArr[0])")
                            // var Da:[String] = fullNameArr[0].characters.split{$0 == "\""}.map(String.init)
                            var ca = fullNameArr[3].characters.split{$0 == " "}.map(String.init)
                            _ = fullNameArr[4].characters.split{$0 == " "}.map(String.init)
                            
                            var fa = fullNameArr[5].characters.split{$0 == " "}.map(String.init)
                            var ta = fullNameArr[4].characters.split{$0 == "\""}.map(String.init)
                            
                            var string:String = ""
                            if ta.count <= 3 {
                                var taa = ta[2].characters.split{$0 == " "}.map(String.init)
                                string = taa[1]
                            }
                            else{
                                
                                string = ta[3]
                            }
                            
                            let recipe:ingredient = ingredient(init_recipe_id: ca[3], init_ingredient: string, init_serving_size: fa[3])
                            self.masterarray.append(recipe)
                            
                        }
                        
                        
                    }
                        
                    catch{
                        print("error serializing jon data: \(error)")
                    }
                    DispatchQueue.main.async(execute: { () -> Void in
                        
                        self.kflagtwo = 0
                        self.tableView.reloadData()
                        
                    })
                    
                }
                task.resume()
                
            }
        }
    }
    /*
     brings count of recipes in so the select function above knows how long to perform the json statement
     
     */
    func countrecipes(){
        
        let url = URL(string: "https://cs.okstate.edu/~jtsutto/services.php/\(id)")!
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
                
                var sd:String = "\(json)"
                print("sd")
                print("\(sd)")
                var Da:[String] = sd.characters.split{$0 == "\""}.map(String.init)
                var Daa:[String] = sd.characters.split{$0 == " "}.map(String.init)
                print("cheese")
                print("\(Daa[0])")
                print("cheese")
                print("\(Daa[1])")
                print("cheese")
                print("\(Daa[3])")
                if Daa[1] != "Success"{
                    var ca = Da[2].characters.split{$0 == " "}.map(String.init)
                    
                    var ea = ca[1].characters.split{$0 == ";"}.map(String.init)
                    
                    self.counter = Int(ea[0])!
                }
                else{
                    self.counter = 0
                }
                
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

















