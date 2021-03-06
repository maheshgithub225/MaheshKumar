//
//  SearchViewController.swift
//  Chefulate
//
//  Created by Mahesh Kumar Kankipati on 11/14/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    var guestflag : Bool = true
    var LoginView = LoginViewController()
    
    @IBOutlet weak var nav: UINavigationBar!
    @IBOutlet weak var myRecipes: UIButton!
    @IBOutlet weak var newRecipe: UIButton!
    @IBOutlet weak var FirstNamelabel: UILabel!
    @IBOutlet weak var logoutbutton: UIButton!
    
    var UID: Int = 0
    var F_Name: String = ""
    var L_Name: String = ""
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertControl1.addAction(UIAlertAction(title: "Confirm", style: .destructive, handler: { (action: UIAlertAction!) in self.performSegue(withIdentifier: "backTologin", sender: self)}))
        alertControl1.addAction(Cancel)
        logoutbutton.layer.cornerRadius = 15
        if guestflag == true{
            myRecipes.isEnabled = false
            newRecipe.isEnabled = false
            myRecipes.setTitleColor(UIColor.lightGray, for: UIControlState.disabled)
            newRecipe.setTitleColor(UIColor.lightGray, for: UIControlState.disabled)
            FirstNamelabel.text = "Guest User"
            FirstNamelabel.textColor = UIColor.white
            FirstNamelabel.font = UIFont(name: "Verdana", size: 25)
        }else{
            if("\(F_Name) \(L_Name)" == "Team Chefulate"){
                FirstNamelabel.text = "Team Chefulate"
                
            }else{
                FirstNamelabel.text = F_Name
            }
            FirstNamelabel.textColor = UIColor.white
            FirstNamelabel.font = UIFont(name: "Verdana", size: 25)
        }
        
        // Do any additional setup after loading the view.
    }
    let alertControl1 = UIAlertController(title: "Are you sure?", message: "", preferredStyle: .alert)
    let Cancel = UIAlertAction(title: "Cancel", style: .destructive){
        (result : UIAlertAction) in debugPrint("Okay")
    }
    @IBAction func logout(_ sender: AnyObject) {
        
        
        self.present(alertControl1, animated: true, completion: nil)
    }
    @IBAction func homeUnwind(segue: UIStoryboardSegue){
        print("Home")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewRecipeFromMenu" {
            let vc = segue.destination as! NewRecipeViewController
            vc.UID = UID
            vc.U_Full = "\(F_Name) \(L_Name)"
        }
        if segue.identifier == "myrecipes" {
            let vc = segue.destination as! MyRecipesViewController
            vc.Creator_ID = UID
        }
        if segue.destination is conversiontable{
            let vc = segue.destination as! conversiontable
            
            vc.UID = UID
            
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
    
    
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue){
        
    }
}

