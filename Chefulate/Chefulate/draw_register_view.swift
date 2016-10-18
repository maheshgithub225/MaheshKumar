//
//  draw_register_view.swift
//  Chefulate
//
//  Created by Bryan Reynolds on 10/18/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class draw_register_view: UIView {
    @IBOutlet weak var darkred: UIImageView!
    @IBOutlet weak var usernametext: UITextField!
    @IBOutlet weak var passwordtext: UITextField!

    @IBOutlet weak var confirmtext: UITextField!
    @IBOutlet weak var emailtext: UITextField!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var password: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var confirmemail: UILabel!
    @IBOutlet weak var birthdate: UILabel!
    @IBOutlet weak var acceptterms: UILabel!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var Iagree: UIButton!
    
    @IBOutlet weak var checkmark: UIImageView!
    @IBOutlet weak var acceptteerms: UILabel!
    
    @IBOutlet weak var cheffont: UIImageView!
    @IBOutlet weak var birthdatetext: UITextField!
    let screenSize: CGRect = UIScreen.main.bounds

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let p = CGRect(x:0,y:0,width:screenWidth,height:screenHeight)
let usernametext_frame=CGRect(x:screenWidth/2.77,y:screenHeight/6.24,width:screenWidth/1.69,height:screenHeight/24.5)
        let passwordtext_frame = CGRect(x:screenWidth/2.77,y:screenHeight/4.13,width:screenWidth/1.69,height:screenHeight/24.5)
        let confirmtext_frame = CGRect(x:screenWidth/2.77,y:screenHeight/2.32,width:screenWidth/1.69,height:screenHeight/24.5)
        let emailtext_frame = CGRect(x:screenWidth/2.77,y:screenHeight/3.08,width:screenWidth/1.69,height:screenHeight/24.5)
        let username_frame = CGRect(x:screenWidth/20.77,y:screenHeight/5.8,width:screenWidth/3.42,height:screenHeight/35.05)
        let password_frame = CGRect(x:screenWidth/20.7,y:screenHeight/3.94,width:screenWidth/3.42,height:screenHeight/35.05)

        let email_frame = CGRect(x:screenWidth/20.7,y:screenHeight/3.29,width:screenWidth/3.42,height:screenHeight/35.05)

        let confirmemail_frame = CGRect(x:screenWidth/20.7,y:screenHeight/2.52,width:screenWidth/3.42,height:screenHeight/9.09)

        let birthdate_frame = CGRect(x:screenWidth/14.79,y:screenHeight/1.81,width:screenWidth/3.66,height:screenHeight/35.05)
        let acceptterms_frame = CGRect(x:screenWidth/3.09,y:screenHeight/1.56,width:screenWidth/2.82,height:screenHeight/35.05)
        let cancel_frame = CGRect(x:screenWidth/20.7,y:screenHeight/1.1,width:screenWidth/2.54,height:screenHeight/15.3)
        let Iagree_frame = CGRect(x:screenWidth/1.79,y:screenHeight/1.1,width:screenWidth/2.54,height:screenHeight/15.3)
        let checkmark_frame = CGRect(x:screenWidth/2.9,y:screenHeight/1.5,width:screenWidth/3.23,height:screenHeight/9.31)
        let acceptteerms_frame = CGRect(x:screenWidth/12.8,y:screenHeight/1.28,width:screenWidth/1.2,height:screenHeight/9.95)
        let cheffont_frame = CGRect(x:screenWidth/3.76,y:0,width:screenWidth/2.13,height:screenHeight/6.7)
        let birthdatetext_frame = CGRect(x:screenWidth/2.77,y:screenHeight/1.81,width:screenWidth/1.69,height:screenHeight/24.5)
        darkred.frame = p
        usernametext.frame = usernametext_frame
        passwordtext.frame = passwordtext_frame
        emailtext.frame = emailtext_frame
        confirmtext.frame = confirmtext_frame
        username.frame = username_frame
        password.frame = password_frame
        email.frame = email_frame
        confirmemail.frame = confirmemail_frame
        birthdate.frame = birthdate_frame
        acceptterms.frame = acceptterms_frame
        cancel.frame = cancel_frame
        Iagree.frame = Iagree_frame
        acceptteerms.frame = acceptteerms_frame
        birthdatetext.frame = birthdatetext_frame
        checkmark.frame = checkmark_frame
        cheffont.frame = cheffont_frame
        // Drawing code
        
        
    }
    

}
