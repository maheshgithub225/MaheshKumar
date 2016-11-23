//
//  NewInstructionViewController.swift
//  Chefulate
//
//  Created by Johnathan Taylor Sutton on 11/20/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class NewInstructionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var cTableView: UITableView!
    
    @IBOutlet weak var addinstructionbutton: UIButton!
    @IBOutlet weak var backbutton: UIButton!
    @IBOutlet weak var saveinstruction: UIButton!
    var radius : Int = Int()
    var R_ID: Int = Int()
    var Sequence: Int = 1
    var InsToBeAdded = ""
    
    struct instructions{
        let I_Data: String
    }
    
    var ins_data = [instructions]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("R_ID :\(R_ID)")
        radius = 15
        cTableView.delegate = self
        cTableView.dataSource = self
        cTableView.backgroundColor = UIColor.clear
        addinstructionbutton.layer.cornerRadius = CGFloat(radius)
        backbutton.layer.cornerRadius = CGFloat(radius)
        saveinstruction.layer.cornerRadius = CGFloat(radius)
        getInstructions()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if( segue.identifier == "AddInstruction"){
            let vc = segue.destination as! RecipeInstructionsViewController
            vc.R_ID = R_ID
            vc.Sequence = Sequence
        }
    }
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ins_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.textLabel?.text = "\(ins_data[indexPath.row].I_Data)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func getInstructions(){
        let url = URL(string: "https://cs.okstate.edu/~jtsutto/services.php/20/\(R_ID)")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url!){ (data, response, error)in
            guard error == nil else {
                print("Error in session call \(error)")
                return
            }
            guard let result = data else {
                print("No data received")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: result, options: .allowFragments) as? NSDictionary
                print("JSON delete data returned : \(json)")
                if(json?.count != nil){
                    for x in (1...(Int)((json?.count)!)){
                        let obj = json?["\(x)"] as! NSDictionary
                        self.ins_data.append(instructions(I_Data: obj["Instruction"] as! String))
                    }
                }
                
                print("JSON data returned = \(json)")
            }catch {
                print("Error serializing JSON data : \(error)")
            }
            DispatchQueue.main.async{
                self.cTableView.reloadData()
            }
        }
        task.resume()
    }
    
    @IBAction func unwindToIns(segue: UIStoryboardSegue) {
        if(InsToBeAdded != ""){
            getInstructions()
            InsToBeAdded = ""
        }
    }
    @IBAction func backButton(segue: UIStoryboardSegue) {
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
