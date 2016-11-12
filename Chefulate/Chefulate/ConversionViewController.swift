//
//  ConversionViewController.swift
//  Chefulate
//
//  Created by Bryan Reynolds on 10/17/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
/*
 pounds
 ounces
 cups
 teaspoons
 tablespoons
 
 
 
 */
//

import UIKit

class ConversionViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate{
    @IBOutlet weak var ingredientScroller: UIScrollView!
    @IBOutlet weak var myPicker: UIPickerView!
    
    @IBOutlet weak var myPickertwo: UIPickerView!
    @IBOutlet weak var myPickerthree: UIPickerView!
    
    @IBOutlet weak var myPickerfour: UIPickerView!
    @IBOutlet weak var myPickerfive: UIPickerView!
    
    @IBOutlet weak var myPickersix: UIPickerView!
let pickerData = ["pounds","ounces","tbsp","tsp","cups"]
    let pickerDatatwo = ["pounds","ounces","tbsp","tsp","cups"]
    override func viewDidLoad() {
        super.viewDidLoad()
        myPicker.dataSource = self
        myPicker.delegate = self
        myPickertwo.dataSource = self
        myPickertwo.delegate = self
        myPickerthree.dataSource = self
        myPickerthree.delegate = self
        myPickerfour.dataSource = self
        myPickerfour.delegate = self
        myPickerfive.dataSource = self
        myPickerfive.delegate = self
        myPickersix.dataSource = self
        myPickersix.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView==myPicker{
        return 1
        }
        else if pickerView == myPickertwo{
        return 1
        }
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == myPicker{
     return 5
        }
        if pickerView == myPickertwo{
        return 5
        }
        return 5
        
        
        
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == myPicker{
            print("aaaaaaa")
        return pickerData[row]
        }
        else if pickerView == myPickertwo{
            print("BBBBBBB")
        return pickerDatatwo[row]
        }
        return pickerDatatwo[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
    }
    @IBAction func myUnwindAction(segue: UIStoryboardSegue){
        if let source = segue.source as? add_more_ingredients{
            //count = source.count
            //print("unwind count \(count)")
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

}
