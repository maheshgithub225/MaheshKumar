//
//  NewInstructionViewController.swift
//  Chefulate
//
//  Created by Johnathan Taylor Sutton on 11/20/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class NewInstructionViewController: UIViewController {

    @IBOutlet var cTableView: UITableView!

    @IBOutlet weak var addinstructionbutton: UIButton!
    @IBOutlet weak var backbutton: UIButton!
    @IBOutlet weak var saveinstruction: UIButton!
    var radius : Int = Int()
    var R_ID: Int = Int()
    var Sequence: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("R_ID :\(R_ID)")
        radius = 15
        addinstructionbutton.layer.cornerRadius = CGFloat(radius)
        backbutton.layer.cornerRadius = CGFloat(radius)
        saveinstruction.layer.cornerRadius = CGFloat(radius)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if( segue.identifier == "AddInstruction"){
            let vc = segue.destination as! RecipeInstructionsViewController
            vc.R_ID = R_ID
            vc.Sequence = Sequence
        }
    }
    
    @IBAction func unwindToIns(segue: UIStoryboardSegue) {
        
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
