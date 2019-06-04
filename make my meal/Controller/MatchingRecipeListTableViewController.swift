//
//  MatchingRecipeListTableViewController.swift
//  make my meal
//
//  Created by Insub Lim on 28/5/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import UIKit

class MatchingRecipeListTableViewController: UITableViewController {
    
    var recipeList: [Recipe] = []
    var matchingRecipes: [Recipe] = []
    var addedIngredients: [String] = []
    var recipeToPass: Recipe?
    let dataStorage = DataRepository()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Load saved all recipes
        if let savedRecipes = try? dataStorage.loadRecipes() {
            recipeList = savedRecipes
        }
        
        getAllrecipesMatchingIngredients(searchedIngredients: addedIngredients)
        tableView.reloadData()
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
        
        cell.updateIngredientsObtained(recipe: recipe, ingredientsList: addedIngredients)
        
        return cell
    }
    
    // Get all recipes that contain the added ingredients
    func getAllrecipesMatchingIngredients(searchedIngredients: [String]) {
        for searchedIngredient in searchedIngredients {
            for recipe in recipeList {
                for ingredient in recipe.ingredients {
                    if ingredient.contains(searchedIngredient) && !isInCurrentList(recipeToAdd: recipe, recipeList: matchingRecipes) {

                        matchingRecipes.append(recipe)
                        //Break the loop; do not need to check for another ingredient of an already added recipe, so we go to the next recipe.
                        break
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let recipeDetailsViewController = segue.destination as! RecipeDetailsViewController
        let indexPath = tableView.indexPathForSelectedRow!
        let selectedRecipe = matchingRecipes[indexPath.row]
        
        recipeDetailsViewController.recipeFromList = selectedRecipe
    }
}
