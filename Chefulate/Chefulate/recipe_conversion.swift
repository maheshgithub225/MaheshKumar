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
    var cost_measurement = ""
    var cost:Double = 0
    var original_cost:Double = 0
    var ispressed:Bool = false
    var manual:Double = 0
    init(init_ingredient: String, init_measurement:String,init_quantity: String,init_original:String,init_cost_measurement:String, init_cost:Double){
        self.ingredient = init_ingredient
        self.measurement = init_measurement
        self.quantity = init_quantity
        self.original = init_original
        self.cost_measurement = init_cost_measurement
        self.cost = init_cost
        original_cost = init_cost
        
        
    }
    func ingredientdisplay() -> String{
        return "\(ingredient)   \(quantity)   \(fraction) \(measurement)"
    }
    func locate() -> String{
        return "Price: $\(String(format: "%.04g",cost)) for \(quantity) \(cost_measurement)"
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












