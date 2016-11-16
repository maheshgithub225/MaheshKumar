//
//  conversiontable.swift
//  Chefulate
//
//  Created by Jayme Crosby on 11/13/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//


import UIKit


class conversiontable: UIViewController, UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate {
    
    
    @IBOutlet weak var viewc: UITableView!
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var steplabel: UILabel!
   
    
    @IBOutlet weak var servingsize: UILabel!
    
    
    
    
    
    var kflag=0
    var g:String = ""
    var counter = 0
    var count = 2
    var countertwo = 0
    var counterthree = 1
    var id:String = "0"
    var counterfour = 1
    var scaling:Double = 0
    var fraction:String = ""
    var y:Double = 0
    var masterarray = [recipe_ingredient]()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewc.delegate = self
        viewc.dataSource = self
        self.hideKeyboardWhenTappedAround()
        // self.countrecipes()
        /*
         print("OOOO")
         var when = DispatchTime.now() + 1.0
         countrecipes()
         DispatchQueue.main.asyncAfter(deadline: when) {
         if self.counterfour == 1{
         self.selectdb()
         }
         }
         //  self.table.reloadData()
         let n = DispatchTime.now() + 2.0
         DispatchQueue.main.asyncAfter(deadline: n) {
         
         
         self.counterthree = 0
         self.viewc.reloadData()
         print("\(self.masterarray[0])")
         }
         */
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any!){
        if let destination = segue.destination as? recipelisttwo{
            
            counterthree=1
            masterarray.removeAll()
        }
    }
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return masterarray.count
    }
    
    func tableView(_ cellForRowAttableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        print("AAAAAAAAAAAAAAAAAA")
        
        let cell = viewc.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        if counterthree == 0{
            print("GGGGG")
            
            
            print("\(self.masterarray[indexPath[1]].ingredientdisplay())")
            cell.textLabel?.text = "\(self.masterarray[indexPath[1]].ingredientdisplay())"
        }
        
        return cell
    }
    
    
    
   
    @IBAction func stepaction(_ sender: UIStepper) {
        steplabel.text = "\(stepper.value)"
        let serving = Double(servingsize.text!)
        scaling = stepper.value / serving!
    }
    
    @IBAction func submit(_ sender: UIButton) {
        convert_measurements()
        viewc.reloadData()
    }
 
    
    
 
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(conversiontable.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    @IBAction func myUnwindAction(segue: UIStoryboardSegue){
        if let source = segue.source as? recipelisttwo{
            g = source.g
            servingsize.text = source.servingsize
            print("unwind")
            print(g)
            id=g
            //  print("unwind count \(count)")
        }
        //  counter=1
        countrecipes()
        var when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            if self.counterfour == 1{
                self.selectdb()
            }
        }
        //  self.table.reloadData()
        when = DispatchTime.now() + 1.0
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            
            self.counterthree = 0
            self.viewc.reloadData()
            
        }
        
    }
    
    func selectdb(){
        print("select")
        if countertwo == 0{
            let url = URL(string: "https://cs.okstate.edu/~rbryanm/combined_tables.php/\(id)")!
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
                        //   print(sd)
                        
                        let fullNameArr = sd.characters.split{$0 == ";"}.map(String.init)
                        
                        //  print("\( fullNameArr[0])")
                        //  print("EEEEE")
                        // var Da:[String] = fullNameArr[0].characters.split{$0 == "\""}.map(String.init)
                        var ca = fullNameArr[1].characters.split{$0 == " "}.map(String.init)
                        var ea = fullNameArr[2].characters.split{$0 == "\""}.map(String.init)
                        //var ga = ea[3].characters.split{$0 == "\""}.map(String.init)
                        var fa = fullNameArr[3].characters.split{$0 == " "}.map(String.init)
                        
                        var recipe:recipe_ingredient = recipe_ingredient(init_ingredient: ea[3], init_measurement:ca[3], init_quantity: fa[3],init_original: fa[3])
                        self.masterarray.append(recipe)
                        
                    }
                    
                    
                }
                    
                catch{
                    print("error serializing jon data: \(error)")
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    
                    //  self.tableView.reloadData()
                    
                })
                
            }
            task.resume()
            
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
    
    func convert_measurements(){
        print("scaling \(scaling)")
        //var measurement:Double = 0
        var x:Double = 0
        
        //step label variable
        /*
         input
         1 cup = 250
         1 pint=600
         1 tablespoon=15
         1 tsp=5
         1 ounce =30
         */
        
        for index in stride(from: 0, to: self.counter, by: +1) {
            /*
             var y:Double = 0
             if masterarray[index].measurement == "cup"{
             measurement = Double(masterarray[index].quantity)!
             measurement = 250 * measurement * scaling
             }
             else if masterarray[index].measurement == "pint"{
             measurement = Double(masterarray[index].quantity)!
             measurement = 600 * measurement * scaling
             }
             else if masterarray[index].measurement == "tablespoon"{
             
             measurement = Double(masterarray[index].quantity)!
             measurement = 15 * measurement * scaling
             }
             else if masterarray[index].measurement == "tsp"{
             
             measurement = Double(masterarray[index].quantity)!
             measurement = 5 * measurement * scaling
             }
             else {
             
             measurement = Double(masterarray[index].quantity)!
             measurement = 30 * measurement * scaling
             }
             print("measurement \(measurement)")
             
             
             
             if measurement>2000 {
             x = floor( measurement/600)
             var t = Int(x) % 600    //return units in pints
             y = Double(t)
             y = Double(return_remainder(d: y))
             
             }
             else if measurement<2000 && measurement>450{
             x = floor( measurement/250)
             var t = Int(x) % 250    //return units in pints
             y = Double(t)
             y = Double(return_remainder(d: y))
             }
             else if measurement<=450 && measurement>90{
             x = floor( measurement/30)
             var t = Int(x) % 30    //return units in pints
             y = Double(t)
             y = Double(return_remainder(d: y))
             }
             else if measurement<=90 && measurement>45{
             x = floor( measurement/15)
             var t = Int(x) % 15    //return units in pints
             y = Double(t)
             y = Double(return_remainder(d: y))
             }
             else{
             x = floor( measurement/5)
             var t = Int(x) % 5    //return units in pints
             y = Double(t)
             y = Double(return_remainder(d: y))
             }
             */
            masterarray[index].y = 0
            x = Double(masterarray[index].original)!
            x = x * scaling //+ masterarray[index].y
            masterarray[index].y = x
            x = floor(x)
            masterarray[index].quantity = "\(Double(x))"
            var s = masterarray[index].y - x
            print("SSSS \(s)")
            print("XX")
            print("\((masterarray[index].y))")
            print(x)
            masterarray[index].fraction = return_remainder(d: s)
            print("\(return_remainder(d:s))")
        }
        
        
        
        
    }
    
    
    func return_remainder(d:Double)->String{
        y = d
        if y<=0.15 && y>0 {
            y = 0
            return ""//even unit
        }
        else if y<=0.29 && y>0.15{
            y = 0.25   // 1/4
            return "1/4"
        }
        else if(y<=0.45 && y>0.29){
            y = 0.33     //1/3
            return "1/3"
        }
        else if y<=0.65 && y>0.45{
            y = 0.5      // y=1/2
            return "1/2"
        }
        else if(y<=0.85 && y>0.65){
            y = 0.75      // y=3/4
            return "3/4"
        }
        return ""
    }
    
    func countrecipes(){
        
        let url = URL(string: "https://cs.okstate.edu/~rbryanm/combined_count.php/\(id)")!
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
            
        }
        task.resume()
        
    }
    
}








