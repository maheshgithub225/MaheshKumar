//
//  ViewController.swift
//  Chefulate
//
//  Created by Johnathan Taylor Sutton on 10/11/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var appname: UIImageView!
    @IBOutlet weak var applogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animateKeyframes(withDuration: 0.8, delay: 0.5, options: .autoreverse, animations:{
            self.applogo.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            },
                                completion: {(finished) -> Void in
        self.performSegue(withIdentifier: "loginScreen", sender: self)
        
        })
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

