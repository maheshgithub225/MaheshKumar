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
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    let screenSize: CGRect = UIScreen.main.bounds
  
    let capture=UIImage(named: "dark red.png")
    let capturetwo=UIImage(named: "chefulate enlarged.png")
    
    
    override func draw(_ rect: CGRect) {
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = UIColor.green
        button.setTitle("Test Button", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
      
        // Draws selfie below_________________
        guard let capture=capture else{
            return
        }
        guard let capturetwo=capturetwo else{
            return
        }
        
        guard UIGraphicsGetCurrentContext() != nil else {return}
        
        //310-320, 510-550    2.97      2
        let p = CGRect(x:0,y:0,width:screenWidth,height:screenHeight)
        let ptwo = CGRect(x:100,y:0,width:(capture.size.width/1.8),height:capturetwo.size.height/1.73)
        let button_frame = CGRect(x:(screenWidth/2)-(register.frame.width/2),y:screenHeight/1.7, width: screenWidth/2, height: screenHeight/8)
       
        register.frame = button_frame
        
      //  capture.draw(in: p)
      //  capturetwo.draw(in: ptwo)
  //self.addSubview(button)

}
    func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }
}



















