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
    
    var UID: Int = 0
    var F_Name: String = ""
    var L_Name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if guestflag == true{
            myRecipes.isEnabled = false
            newRecipe.isEnabled = false
            myRecipes.setTitleColor(UIColor.lightGray, for: UIControlState.disabled)
            newRecipe.setTitleColor(UIColor.lightGray, for: UIControlState.disabled)
        }
        // Do any additional setup after loading the view.
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
