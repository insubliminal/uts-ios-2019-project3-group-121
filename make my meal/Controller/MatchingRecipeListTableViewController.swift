//
//  MatchingRecipeListTableViewController.swift
//  make my meal
//
//  Created by Gayun Kim on 30/5/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import UIKit

class MatchingRecipeListTableViewController: UITableViewController {
    
    var relevantRecipes: [String] = []
    var recipeChosenInTable = ""
    var recipeList: [Recipe] = []
    var matchingRecipes: [Recipe] = []
    var searchedItems: [String] = []
    var recipeToPass: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Test data
        let pizza = Recipe(name: "Pizza", description: "Meme", ingredients: ["dough", "cheese", "milk"])
        let pasta = Recipe(name: "Pasta", description: "Meme", ingredients: ["pasta", "cheese", "butter"])
        let salad = Recipe(name: "Salad", description: "Meme", ingredients: ["head cabbage", "rocket", "tomato"])
        let fruitSalad = Recipe(name: "Fruit Salad", description: "Meme", ingredients: ["apple", "banana", "orange"])
        let bbqChicken = Recipe(name: "BBQ Chicken", description: "Meme", ingredients: ["rotisserie", "bbq sauce", "saltshaker"])
        
        //Add test data into table.
        recipeList = [pizza, pasta, salad, fruitSalad, bbqChicken]
        
        getAllrecipesMatchingIngredients(searchedIngredients: searchedItems)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingRecipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MatchingRecipeTableViewCell
        
        let recipe = matchingRecipes[indexPath.row]
        cell.update(with: recipe)
        
        return cell
    }
    
    func getAllrecipesMatchingIngredients(searchedIngredients: [String]) {
        
        for searchedIngredient in searchedIngredients {
            for recipe in recipeList {
                for ingredient in recipe.ingredients {
                    if searchedIngredient.contains(ingredient) && !isInCurrentList(recipeToAdd: recipe) {
                        
                        matchingRecipes.append(recipe)
                        //Break the loop; do not want to double add a recipe, so we go to the next recipe.
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let recipeDetailsViewController = segue.destination as! RecipeDetailsViewController
        
        let indexPath = tableView.indexPathForSelectedRow!
        let selectedRecipe = matchingRecipes[indexPath.row]
        recipeDetailsViewController.recipeFromList = selectedRecipe
    }
}



