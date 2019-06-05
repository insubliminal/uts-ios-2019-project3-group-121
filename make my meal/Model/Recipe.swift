//
//  Recipe.swift
//  make my meal
//
//  Created by Insub Lim on 22/5/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import Foundation


class Recipe: Codable, Equatable {
    
    var name: String
    var description: String
    var ingredients: [String]
    var time: String
    
    init(name: String, description: String, ingredients: [String], time: String) {
        self.name = name
        self.description = description
        self.ingredients = ingredients
        self.time = time
    }
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool{
        return lhs.name == rhs.name
    }
}

func ingredientIsInCurrentList(ingredient: String, ingredientList: [String]) -> Bool {
    for existingIngredient in ingredientList {
        if ingredient == existingIngredient {
            return true
        }
    }
    return false
}

func isInCurrentList(recipeToAdd: Recipe, recipeList: [Recipe]) -> Bool {
    for recipe in recipeList {
        if recipeToAdd == recipe {
            return true
        }
    }
    return false
}

func calculateNumberOfIngredientsHad(ingredientsInList: [String], recipeList: Recipe) -> Int {
    
    var count = 0
    
    for requiredIngredient in recipeList.ingredients {
        for ingredientHad in ingredientsInList {
            if (ingredientHad == requiredIngredient) {
                count += 1
            }
        }
    }
    return count
}
