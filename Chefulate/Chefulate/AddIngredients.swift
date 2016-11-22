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
    var Units : String = "Pounds"
    var value : String = String()
    let PickerData = ["Pounds","Ounces","Tbsp","Tsp","Cups"]
    var value1 : String = String()
    var value2 : String = String()
    var value3 : String = String()
    var radius : Int = Int()
    
    var R_ID: Int = Int()
    var I_Name: String = String()
    var I_ID: Int = Int()
    var I_Amount: Int = Int()
    var I_Unit: String = String()
    
    @IBOutlet weak var savebutton: UIButton!
    @IBOutlet weak var closebutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("RID: \(R_ID)")
        pickerData.dataSource = self
        pickerData.delegate = self
        ingredientName.delegate = self
        ingredientName.text = value
        radius = 15
        savebutton.layer.cornerRadius = CGFloat(radius)
        closebutton.layer.cornerRadius = CGFloat(radius)
        pickerData.layer.cornerRadius = CGFloat(radius)
        
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
            alertControl.addAction(Addmore)
            alertControl.addAction(done)
            self.present(alertControl, animated: true, completion: nil)
            // addIngredientData()
        }
        
        //performSegue(withIdentifier: "newRecipe", sender: self)
    }

    @IBAction func saveIng(_ sender: AnyObject) {
        addIng()
    }
    
    @IBAction func backToAddIngredientUnwind(segue: UIStoryboardSegue){
        let vc = segue.source as? IngredientsTableViewController
        I_ID = (vc?.I_ID)!
        I_Name = (vc?.selectedIngredient)!
        ingredientName.text = I_Name
    }
    
    
    @IBAction func backToNewRecipe(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "unwindToNewRecipe", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newRecipe"{
           
        }
        
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return PickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Units = PickerData[row] as String
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PickerData.count
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        amount.resignFirstResponder()
        ingredientName.resignFirstResponder()
        return true
    }

    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddIngredients.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() { 
        view.endEditing(true)
    }

    func addIng(){
        I_Amount = (Int)(amount.text!)!
        I_Unit = Units as String
        let RID = R_ID
        let urlString = "https://cs.okstate.edu/~jtsutto/services.php/12/\(RID)/\(I_ID)/\(I_Amount)/\(I_Unit)"
        let url = URL(string: urlString )
        print("URL: \(url)")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url!){(data,response,error)in
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
                print("JSON addIng data returned : \(json)")
            }catch {
                print("Error Serializing JSON data : \(error)")
            }
            DispatchQueue.main.async {
                //
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
