//
//  data.swift
//  MW02_Reynolds_Bryan
//
//  Created by Jayme Crosby on 11/6/16.
//  Copyright © 2016 bryan reynolds. All rights reserved.
//

import Foundation

class recipe_ingredient{
    
    //var recipe_name = ""
   // var serving_size = ""
    var ingredient:String = ""
    var measurement:String = ""
    var quantity:String = ""
    init(init_ingredient: String, init_measurement:String,init_quantity: String){
        self.ingredient = init_ingredient
        self.measurement = init_measurement
        self.quantity = init_quantity
        
       
    }
    func ingredientdisplay() -> String{
        return "\(ingredient)   \(quantity) \(measurement)"
    }
    func locate() -> String{
        return ""
    }
    
    
}
