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
    
    @IBOutlet weak var closebutton: UIButton!
    @IBOutlet weak var savebutton: UIButton!
    var Sequence: Int = Int()
    var R_ID: Int = Int()
    
    
    var radius : Int = Int()
    
    @IBAction func saveInstructions(_ sender: AnyObject) {
        let alertControl = UIAlertController(title: "Ingredient Saved", message: "", preferredStyle: .alert)
        let Addmore = UIAlertAction(title: "Add more..", style: .destructive){
            (result : UIAlertAction) in debugPrint("Add")
        }
        let done = UIAlertAction(title: "Done", style: .destructive) { (_) -> Void in
            self.addInstructionData()
        }
        alertControl.addAction(done)
        alertControl.addAction(Addmore)
        self.present(alertControl, animated: true, completion: nil)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("R_ID:\(R_ID) Sequence: \(Sequence)")
        instructionLabel.text! = "Instruction #\(Sequence)"
        instruction1.delegate = self
        instruction1.backgroundColor = UIColor(white: 1, alpha: 0.5)
        radius = 15
        savebutton.layer.cornerRadius = CGFloat(radius)
        
        // Do any additional setup after loading the view.
    }
    func addInstructionData(){
        
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
