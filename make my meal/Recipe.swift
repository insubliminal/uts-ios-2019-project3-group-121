//
//  Recipe.swift
//  make my meal
//
//  Created by Insub Lim on 22/5/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import Foundation


class Recipe {
    
    var name: String
    var description: String
    var ingredients: [String]
    
    init(name: String, description: String, ingredients: [String]) {
        
        self.name = name
        self.description = description
        self.ingredients = ingredients
    }
}

