//
//  MatchingRecipeTableViewCell.swift
//  make my meal
//
//  Created by Gayun Kim on 30/5/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import UIKit

class MatchingRecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var ingredientsHad: UILabel!
    
    
    func update(with recipe: Recipe) {
        recipeImageView.image = UIImage(named: recipe.name)
        recipeName.text = recipe.name
    }
    
    func updateIngredientsObtained(recipe: Recipe, ingredientsList: [String]) {
        ingredientsHad.text = "\(calculateNumberOfIngredientsHad(ingredientsInList: ingredientsList, recipeList: recipe)) / \(recipe.ingredients.count) Ingredients"
    }
}

