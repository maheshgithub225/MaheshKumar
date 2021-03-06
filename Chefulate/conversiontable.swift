//
//  conversiontable.swift
//  Chefulate
//
//  Created by Bryan Reynolds on 11/13/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//




import UIKit




class conversiontable: UIViewController, UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate {
    
    
    @IBOutlet weak var backbutton: UIButton!
    
    @IBOutlet weak var calculatebutton: UIButton!
    @IBOutlet weak var loadrecipebutton: UIButton!
    var radius : Int = Int()
    @IBOutlet weak var viewc: UITableView!
    
    @IBOutlet weak var stepper: UIStepper!
    
    
    @IBOutlet weak var steplabel: UILabel!
    
    @IBOutlet weak var servingsize: UILabel!
    
    
    @IBOutlet weak var totalprice: UILabel!
    
    
    @IBOutlet weak var destext: UILabel!
    
    
    var UID = 0
    var kflag=0 //switchvariable helps for hson
    var kflagtwo = 1 //switchvariable helps for printing different messages in different states
    var kflagthree = 0 //switch variable
    var seguewayflag = 0
    var kflagfour = 1
    var g:String = "" //holds recipeid
    var counter = 0  //holds count for recipes
    var count = 2
    var popuptext:String = ""  //holds string from alert controller whn clicking on accessory
    var countertwo = 0
    var counterthree = 1
    var id:String = "0"  //eventually changes to recipe id
    var counterfour = 1 //used with jason
    var scaling:Double = 0   //new serving size divided by original serving size
    var fraction:String = ""  //shows fractions for converted measurements
    var y:Double = 0  //used for math funitons in converted measurements
    var masterarray = [recipe_ingredient]()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewc.delegate = self
        viewc.dataSource = self
        self.hideKeyboardWhenTappedAround()
        radius = 15
        calculatebutton.layer.cornerRadius = CGFloat(radius)
        backbutton.layer.cornerRadius = backbutton.frame.width/2
        loadrecipebutton.layer.cornerRadius = CGFloat(radius)
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
        if segue.destination is recipelisttwo{
            let vc = segue.destination as! recipelisttwo
            destext.text = ""
            vc.id = UID
            counterthree=1
            masterarray.removeAll()
        }
    }
    
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        if kflagtwo == 1 || kflagtwo == 2 || kflagtwo == 3{
            return 1
        }
        return masterarray.count
    }
    
    func tableView(_ cellForRowAttableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        
        let cell = viewc.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        if kflagtwo == 0 && kflagthree == 0{
            if counterthree == 0{
                
                cell.textLabel?.text = "\(self.masterarray[indexPath[1]].ingredientdisplay())"
                cell.detailTextLabel?.text = "\(self.masterarray[indexPath[1]].locate())"
                
            }
        }
            
        else if kflagtwo == 1 {
            cell.textLabel?.text = "No ingredients loaded yet"
            cell.detailTextLabel?.text = " "
        }
        else if kflagtwo == 2{
            cell.textLabel?.text = "Please wait"
            cell.detailTextLabel?.text = " "
        }
        else if kflagthree == 1{
            cell.textLabel?.text = "\(self.masterarray[indexPath[1]].ingredientdisplay())"
            cell.detailTextLabel?.text = "Please press calculate to recalculate costs"
        }
        else {
            cell.textLabel?.text = "No ingredients found"
            cell.detailTextLabel?.text = " "
        }
        
        return cell
    }
    
    
    
    
    @IBAction func stepaction(_ sender: UIStepper) {
        
        steplabel.text = "\(stepper.value )"
        let serving = Double(servingsize.text!)
        scaling = stepper.value / serving!
    }
    /*
     calculate button, which converst measurements and cost, changes switch variable(initially changes to let users know to recalculate
     
     */
    @IBAction func submit(_ sender: UIButton) {
        convert_measurements()
        kflagthree = 0
        viewc.reloadData()
    }
    
    /*
     promts an alert controller with a textfield
     
     */
    func promptForAnswer(number: Int) {
        let ac = UIAlertController(title: "Update price", message: nil, preferredStyle: .alert)
        
        ac.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Enter price per unit"
            
            textField.keyboardType = UIKeyboardType.numberPad
        })
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            _ = ac.textFields![0]
            
            self.popuptext = "\(ac.textFields![0].text)"
            var fa = self.popuptext.characters.split{$0 == "\""}.map(String.init)
            if fa[1] != ")"{
                
                
                self.masterarray[number].manual = Double(fa[1])!
            }
            else{
                self.masterarray[number].manual = 0
            }
            
            var E:Double = Double(self.masterarray[number].original)!
            
            let w:Double = self.masterarray[number].manual * E
            self.masterarray[number].manual = w
            self.scaling = Double(self.steplabel.text!)! / Double(self.servingsize.text!)!
            
            E = E * self.scaling
            self.masterarray[number].cost =  w * self.scaling
            self.reload()
            
            self.viewc.reloadData()
        }
        //kflagthree = 1
        
        ac.addAction(submitAction)
        //  ac.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        present(ac, animated: true)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        if(masterarray.count != 0){
            promptForAnswer(number: indexPath[1])
            
            masterarray[indexPath[1]].ispressed = true
            destext.text = "Load the recipe again to change to Walmart prices"
        }
        
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
            seguewayflag = source.kflag
            print("look here, \(seguewayflag)")
            if source.kflag != 0{
                g = source.g
                servingsize.text = source.servingsize
                
                scaling = 1
                
                
                id=g
            }
        }
        if seguewayflag != 0 {
            
            self.kflagtwo = 2
            self.viewc.reloadData()
            
            
            self.countrecipes()
            var when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when) {
                if self.counterfour == 1{
                    self.selectdb()
                }
            }
            
            when = DispatchTime.now() + 2.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                
                
                if self.masterarray.count != 0{
                    self.kflagtwo = 0
                }
                else{
                    self.kflagtwo = 3
                }
                self.viewc.reloadData()
                self.init_total()
                
            }
        }
        else{
            self.viewc.reloadData()
            self.totalprice.text = "$0"
            self.servingsize.text = "0"
            
        }
    }
    /*
     select all ingredients from the recipe chosen on recipelisttwo
     
     */
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
                        
                        let fullNameArr = sd.characters.split{$0 == ";"}.map(String.init)
                        
                        var ca = fullNameArr[1].characters.split{$0 == " "}.map(String.init)
                        var ea = fullNameArr[2].characters.split{$0 == "\""}.map(String.init)
                        
                        var qa = fullNameArr[6].characters.split{$0 == "\""}.map(String.init)
                        var qaa = qa[2].characters.split{$0 == " "}.map(String.init)
                        var la = fullNameArr[7].characters.split{$0 == "\""}.map(String.init)
                        //var ga = ea[3].characters.split{$0 == "\""}.map(String.init)
                        var fa = fullNameArr[3].characters.split{$0 == " "}.map(String.init)
                        
                        let recipe:recipe_ingredient = recipe_ingredient(init_ingredient: ea[3], init_measurement:ca[3], init_quantity: fa[3],init_original: fa[3],init_cost_measurement: qaa[1],init_cost: (Double(la[3])!*Double(fa[3])!))
                        self.masterarray.append(recipe)
                        
                    }
                    
                    
                }
                    
                catch{
                    print("error serializing jon data: \(error)")
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    self.counterthree = 0
                    self.viewc.reloadData()
                    
                })
                
            }
            task.resume()
            
        }
    }
    /*
     sets up total on way back from load recipe
     
     */
    func init_total(){
        var z:Double = 0
        let w:Double = 0
        var ultracounter:Double = 0
        for index in stride(from: 0, to: self.counter, by: +1) {
            
            if masterarray.count != 0{
                
                z = masterarray[index].original_cost * scaling
                if masterarray[index].ispressed == true{
                    
                    z = masterarray[index].manual * scaling
                }
            }
            else{
                z = 0
            }
            print("secondtext")
            print(z)
            
            print("secondtext")
            print(w)
            ultracounter = ultracounter + z
            print("ulta")
            print(ultracounter)
            
            
        }
        totalprice.text = "$\(String(format: "%.04g",ultracounter))"
        
        
    }
    func reload(){
        kflagthree = 1
    }
    
    /*
     converts measurements for the conversion calculator as well as cost
     
     */
    func convert_measurements(){
        print("scaling \(scaling)")
        
        var x:Double = 0
        
        var z:Double = 0
        var w:Double = 0
        var ultracounter:Double = 0
        if masterarray.count != 0{
            for index in stride(from: 0, to: self.counter, by: +1) {
                if masterarray[index].ispressed == true {
                    z = masterarray[index].manual
                    print("ZZZZZZZZ")
                    print(z)
                }
                else{
                    z = masterarray[index].original_cost
                }
                w = z * scaling
                print("here in convert \(scaling)    \(z)")
                masterarray[index].cost = w
                ultracounter = ultracounter + w
                
                masterarray[index].y = 0
                x = Double(masterarray[index].original)!
                x = x * scaling //+ masterarray[index].y
                masterarray[index].y = x
                x = floor(x)
                masterarray[index].quantity = "\(Double(x))"
                
                let s = masterarray[index].y - x
                print("SSSS \(s)")
                print("XX")
                print("\((masterarray[index].y))")
                print(x)
                masterarray[index].fraction = return_remainder(d: s)
                print("\(return_remainder(d:s))")
            }
            
            
            totalprice.text = "$\(String(format: "%.04g",ultracounter))"
        }
        else {
            totalprice.text = "$0"
        }
    }
    /*
     converts decimals into fractions.  for ease of the user exact fractions are not used, but typical fractions seen in cooking recipes.
     
     */
    
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
        else if(y<=0.99 && y>0.65){
            y = 0.75      // y=3/4
            return "3/4"
        }
        return ""
    }
    /*
     counts the number of ingredients before selecting them to control the counter loop in select sql
     
     */
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
                // print("LLLL")
                // print("\(json)")
                var sd:String = "\(json)"
                var Da:[String] = sd.characters.split{$0 == "\""}.map(String.init)
                // print("second")
                print("\(Da[2])")
                var ca = Da[2].characters.split{$0 == " "}.map(String.init)
                //  print("third")
                print("\(ca[1])")
                var ea = ca[1].characters.split{$0 == ";"}.map(String.init)
                // print("fourth")
                // print("\(ea[0])")
                self.counter = Int(ea[0])!
                
            }
                
                
            catch{
                print("error serializing jon data: \(error)")
            }
            
        }
        task.resume()
        
    }
    
}




















