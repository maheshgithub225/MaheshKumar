//
//  recipelisttwo.swift
//  Chefulate
//
//  Created by Bryan Reynolds on 11/13/16.
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
    var kflagtwo = 1
    var servingsize:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countrecipes()
        
       
        
            
            
        
         let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.selectdb()
            
            
        
  
        }
       
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
        if kflagtwo == 0{
        return masterarray.count
        }
    return 1
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(counter)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "secondcell", for: indexPath)
        if kflagtwo == 0 {
            
            
            //   if  indexPath[1] == 0{
            //   cell.textLabel?.text = "\(masterarray[(indexPath[1]])"
            //   }
            //  else{
            cell.textLabel?.text = "\(masterarray[indexPath[1]].ingredientdisplay())"
            cell.detailTextLabel?.text="\(masterarray[indexPath[1]].seconddisplay())"
            //  }
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
        //run select operation
        return true
        
        
    }
  

    @IBAction func cancelaction(_ sender: UIBarButtonItem) {
        
       print("BBBBBB")
        if kflagtwo == 0{
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
                 
                    print("LLLLLLLLL")
                    
                    for index in stride(from: 0, to: self.counter, by: +1) {
                        
                        var sd: String = "\(json?[index])"
                        print(sd)
                        
                        let fullNameArr = sd.characters.split{$0 == ";"}.map(String.init)
                        
                        print("\( fullNameArr[0])")
                        // var Da:[String] = fullNameArr[0].characters.split{$0 == "\""}.map(String.init)
                        var ca = fullNameArr[3].characters.split{$0 == " "}.map(String.init)
                        _ = fullNameArr[4].characters.split{$0 == " "}.map(String.init)
                        
                        var fa = fullNameArr[5].characters.split{$0 == " "}.map(String.init)
                        var ta = fullNameArr[4].characters.split{$0 == "\""}.map(String.init)
                        print("TTTTT")
                        var string:String = ""
                        if ta.count <= 3 {
                             var taa = ta[2].characters.split{$0 == " "}.map(String.init)
                        string = taa[1]
                        }
                        else{
                            
                            string = ta[3]
                        }
                        //print("\(ta[3])")
                        print("TTTTT")
                        
                        print("TTTTT")
                        print("\(fa[3])")
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


