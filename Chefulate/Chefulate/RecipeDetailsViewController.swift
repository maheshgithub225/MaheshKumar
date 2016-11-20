//
//  RecipeDetailsViewController.swift
//  Chefulate
//
//  Created by Mahesh Kumar Kankipati on 11/20/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var recipeDetailsTableView: UITableView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var servingsize : UILabel!

    var labelName : String = String()
    var serving : Int = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeDetailsTableView.delegate = self
        recipeDetailsTableView.dataSource = self
        recipeDetailsTableView.backgroundColor = UIColor.clear
        recipeName.text = labelName
        servingsize.text = String(serving)
        // Do any additional setup after loading the view.
    }

    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var title : String = String()
        if section == 0 {
            title = "Ingedients"
        }
        if section == 1 {
            title = "Instructions"
        }
        return title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! SearchRecipeTableViewCell
        cell.backgroundColor = UIColor.clear
       
        
        return cell
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
