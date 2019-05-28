//
//  ViewController.swift
//  make my meal
//
//  Created by Insub Lim on 22/5/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var relevantRecipes = [String]()
    var recipeSelected = ""
    var recipeList: [Recipe] = []
    var matchingRecipes: [Recipe] = []
    var searchedItems: [String] = []

    
    override func viewWillAppear(_ animated: Bool) {
      
        //Test data
        let pizza = Recipe(name: "Pizza", description: "Meme", ingredients: ["dough", "cheese", "milk"])
        let pasta = Recipe(name: "Pasta", description: "Meme", ingredients: ["pasta", "cheese", "butter"])
        let salad = Recipe(name: "Salad", description: "Meme", ingredients: ["lettuce", "rocket", "tomato"])
        let fruitSalad = Recipe(name: "Fruit Salad", description: "Meme", ingredients: ["apple", "banana", "orange"])
        let bbqChicken = Recipe(name: "BBQ Chicken", description: "Meme", ingredients: ["chicken", "bbq sauce", "salt"])
        //Add test data into table.
        recipeList = [pizza, pasta, salad, fruitSalad, bbqChicken]
        //matchingRecipes = []
        getAllrecipesMatchingIngredients(searchedIngredients: searchedItems)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return matchingRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecipeTableViewCell
        
        cell.recipeImageView.image = UIImage(named: matchingRecipes[indexPath.row].name )
        cell.recipeName.text = matchingRecipes[indexPath.row].name
        cell.recipeImageView.tag = indexPath.row;
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedRecipe = matchingRecipes[indexPath.row]
        recipeSelected = selectedRecipe.name
        print(recipeSelected)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if recipeSelected == "Fruit Salad" {
            return true
        }
        return false
    }
    
    
    func getAllrecipesMatchingIngredients(searchedIngredients: [String]) {
        
        for searchedIngredient in searchedIngredients {
            for recipe in recipeList {
                for ingredient in recipe.ingredients {
                    if searchedIngredient.contains(ingredient) && !isInCurrentList(recipeToAdd: recipe) {
                        
                        matchingRecipes.append(recipe)
                        //Break the loop; do not want to double add a recipe.
                        break
                    }
                }
            }
        }
    }
    
    func isInCurrentList(recipeToAdd: Recipe) -> Bool {
        
        for recipe in matchingRecipes {
            
            if recipeToAdd.name == recipe.name {
                return true
            }
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

