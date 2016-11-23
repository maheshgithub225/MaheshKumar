//
//  RecipeInstructionsViewController.swift
//  Chefulate
//
//  Created by Mahesh Kumar Kankipati on 11/19/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class RecipeInstructionsViewController: UIViewController,UITextViewDelegate {
    
    @IBOutlet var instructionLabel: UILabel!
    @IBOutlet weak var instruction1: UITextView!
    @IBOutlet var InstructionBox: UITextView!
    
    @IBOutlet weak var closebutton: UIButton!
    @IBOutlet weak var savebutton: UIButton!
    var Sequence: Int = Int()
    var R_ID: Int = Int()
    
    
    var radius : Int = Int()
    
    @IBAction func saveInstructions(_ sender: AnyObject) {
        let data = self.InstructionBox.text
        let alertControl = UIAlertController(title: "Ready to save?", message: "", preferredStyle: .alert)
        
        let done = UIAlertAction(title: "Yes", style: .destructive) { (_) in
            self.addInstructionData(Data:data!)
        }
        
        let cancel = UIAlertAction(title: "No", style: .destructive) { (_) in
        }
        
        alertControl.addAction(done)
        alertControl.addAction(cancel)
        self.present(alertControl, animated: true, completion: nil)
        
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("R_ID:\(R_ID) Sequence: \(Sequence)")
        instructionLabel.text! = "Instruction:"
        instruction1.delegate = self
        instruction1.backgroundColor = UIColor(white: 1, alpha: 0.5)
        radius = 15
        savebutton.layer.cornerRadius = CGFloat(radius)
        
        // Do any additional setup after loading the view.
    }
    
    func addInstructionData(Data:String){
        print(Data)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToAddIngredientUnwindWithSegue"{
            let vc = segue.destination as! NewInstructionViewController
            //vc.ins_data.append(Instruction)
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        instruction1.resignFirstResponder()
        
        return true
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RecipeInstructionsViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
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
