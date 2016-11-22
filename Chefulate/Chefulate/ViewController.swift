//
//  ViewController.swift
//  Chefulate
//
//  Created by Johnathan Taylor Sutton on 10/11/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var appname: UIImageView!
    @IBOutlet weak var applogo: UIImageView!
    let transition = CircularTransition()
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animateKeyframes(withDuration: 1.3, delay: 0.5, animations:{
            self.applogo.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            },
                                completion: {(finished) -> Void in
        self.performSegue(withIdentifier: "loginScreen", sender: self)
        
        })
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginScreen"{
        let secondVC = segue.destination as! LoginViewController
        secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .custom
        }
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = applogo.center
        transition.circleColor = UIColor.black
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = applogo.center
        transition.circleColor = UIColor.white
        
        return transition
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

