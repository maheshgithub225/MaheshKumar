//
//  NewRecipeViewController.swift
//  Chefulate
//
//  Created by Mahesh Kumar Kankipati on 11/14/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit
import Foundation

class NewRecipeViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    @IBOutlet weak var RecipeTitle: UITextField!
    @IBOutlet weak var Ingredient1: UITextField!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var pickerData: UIPickerView!
   
    var Units : NSString = NSString()
    let PickerData = ["Pounds","Ounces","Tbsp","Tsp","Cups"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerData.dataSource = self
        pickerData.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func submitRecipe(_ sender: AnyObject) {
        addRecipeData()
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return PickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Units = PickerData[row] as NSString
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PickerData.count
    }

    func addRecipeData(){
        let NewRecipeTitle = RecipeTitle.text!
        let ing1 = Ingredient1.text!
        
        let url = URL(string: "https://cs.okstate.edu/~jtsutto/services.php/0/\(NewRecipeTitle)/\(ing1)")!
        print("URL: \(url)")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url){(data,response,error)in
            guard error == nil else{
                print("Error in session call: \(error)")
                return
            }
            guard let result = data else {
                print("No data reveived")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: result, options: .allowFragments) as? NSDictionary
                print("JSON data returned : \(json)")
            }catch {
                print("Error Serializing JSON data : \(error)")
            }
        }
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "MyRecipesViewController") as UIViewController
        self.present(vc, animated: true, completion: nil)
        task.resume()
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
