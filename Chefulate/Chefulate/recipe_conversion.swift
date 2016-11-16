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
    var recipe_id:String = ""
    var fraction:String = ""
    var original:String = ""
    var y:Double = 0
    init(init_ingredient: String, init_measurement:String,init_quantity: String,init_original:String){
        self.ingredient = init_ingredient
        self.measurement = init_measurement
        self.quantity = init_quantity
        self.original = init_original
        
        
    }
    func ingredientdisplay() -> String{
        return "\(ingredient)   \(quantity)   \(fraction) \(measurement)"
    }
    func locate() -> String{
        return ""
    }
    
    
}




class ingredient{
    
    
    
    var recipe_id:String = ""
    var ingredient:String = ""
    var serving_size:String = ""
    
    var ispressed:Bool = false
    init(init_recipe_id: String, init_ingredient:String,init_serving_size: String){
        self.ingredient = init_ingredient
        self.serving_size = init_serving_size
        
        self.recipe_id = init_recipe_id
        
    }
    func ingredientdisplay() -> String{
        return "Recipe #:\(recipe_id)   \(ingredient) "
    }
    func seconddisplay() -> String{
        return "Serving size: \(serving_size)   "
    }
    
    
    
    
    
    
}












