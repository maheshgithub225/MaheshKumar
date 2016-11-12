//
//  drawsignin.swift
//  Chefulate
//
//  Created by Bryan Reynolds on 10/16/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class drawsignin: UIView {

    @IBOutlet weak var register: UIButton!
   
    @IBOutlet weak var darkred: UIImageView!
    @IBOutlet weak var regi: UIButton!
    @IBOutlet weak var cheflogo: UIImageView!
    @IBOutlet weak var cheffont: UIImageView!

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    let screenSize: CGRect = UIScreen.main.bounds
  
    
    override func draw(_ rect: CGRect) {
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = UIColor.green
        button.setTitle("Test Button", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
      
        // Draws selfie below_________________
        
        guard UIGraphicsGetCurrentContext() != nil else {return}
        
        //310-320, 510-550    2.97      2
        let p = CGRect(x:0,y:0,width:screenWidth,height:screenHeight)
        let ptwo = CGRect(x:screenWidth/7.66,y:screenHeight/6.57,width:screenWidth/1.34,height:screenHeight/2.35)
        let button_frame = CGRect(x:(screenWidth/5.83),y:screenHeight/1.98, width: screenWidth/1.58, height: screenHeight/10.08)
        let button_frametwo = CGRect(x:(screenWidth/5.83),y:screenHeight/1.46, width: screenWidth/1.58, height: screenHeight/10.08)
        let logo_frame=CGRect(x:screenWidth/5.52,y:0,width:screenWidth/1.56,height:screenHeight/5.58)
        //register.frame = button_frame
        //register.layer.cornerRadius = 5
        cheflogo.frame = ptwo
        regi.frame = button_frametwo
        regi.layer.cornerRadius = 5
       // darkred.frame = p
        cheffont.frame = logo_frame
        
      //  capture.draw(in: p)
      //  capturetwo.draw(in: ptwo)
  //self.addSubview(button)

}
    func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }
}



















