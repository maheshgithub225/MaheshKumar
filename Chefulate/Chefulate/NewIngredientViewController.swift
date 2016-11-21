//
//  NewIngredientViewController.swift
//  Chefulate
//
//  Created by Johnathan Taylor Sutton on 11/20/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class NewIngredientViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet var cTableView: UITableView!
    @IBOutlet weak var nextbutton: UIButton!
    
    struct ingredients{
        let I_ID: Int
        let I_Name: String
        let I_Amount: Int
        let I_Unit: String
    }
    var data_array = [ingredients]()
    var radius : Int = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        cTableView.delegate = self
        cTableView.dataSource = self
        cTableView.backgroundColor = UIColor.clear
        nextbutton.layer.cornerRadius = CGFloat(radius)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! SearchRecipeTableViewCell
        
        let row = indexPath.row
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "recipeDetailsView", sender: self)
    }
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        let row = indexPath.row
        print(data_array[row])
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
