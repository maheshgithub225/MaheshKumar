//
//  AddIngredients.swift
//  Chefulate
//
//  Created by Mahesh Kumar Kankipati on 11/13/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class AddIngredients: UIViewController,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var ingredientName: UITextField!
    @IBOutlet weak var pickerData: UIPickerView!
    //  @IBOutlet weak var Unit: UITextField!
    var Units : NSString = NSString()
    var value : String = String()
    let PickerData = ["Pounds","Ounces","Tbsp","Tsp","Cups"]
    var value1 : String = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerData.dataSource = self
        pickerData.delegate = self
        ingredientName.delegate = self
        ingredientName.text = value
        
               // Do any additional setup after loading the view.
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "IngredientsList") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    let alertControl = UIAlertController(title: "Ingredient Saved", message: "", preferredStyle: .alert)
    let Addmore = UIAlertAction(title: "Add more..", style: .destructive){
        (result : UIAlertAction) in debugPrint("Add")
    }
    
    
    
    
    @IBAction func saveCloseButton(_ sender: AnyObject) {
        
        
    
        if ingredientName.text != "" && amount.text != "" {
            let done = UIAlertAction(title: "Done", style: .destructive) { (_) -> Void in
                self.performSegue(withIdentifier: "newRecipe", sender: self)
            }
            let addinstructions = UIAlertAction(title: "Add Instructions?", style: .destructive) { (_) -> Void in
                self.performSegue(withIdentifier: "instructionView", sender: self)
            }
            alertControl.addAction(Addmore)
            alertControl.addAction(addinstructions)
            alertControl.addAction(done)
            self.present(alertControl, animated: true, completion: nil)
        addIngredientData()
        }
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
    func addIngredientData(){
        let IngredName = self.ingredientName.text!
        let quantity = self.amount.text!
        let UnitPicker = Units
        
        let url = URL(string: "https://cs.okstate.edu/~jtsutto/services.php/0/\(IngredName)/\(quantity)/\(UnitPicker)")!
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
