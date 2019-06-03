//
//  AllRecipesTableViewController.swift
//  make my meal
//
//  Created by Grégory O'Connor  on 6/3/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import UIKit

class AllRecipesTableViewController: UITableViewController {

    var recipeList: [Recipe] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Test data
        let pizza = Recipe(name: "Pizza", description: "Step 1:\n\tMake dough\nStep 2:\n\tBake bread", ingredients: ["dough", "cheese", "milk"], time: "45 minutes")
        let pasta = Recipe(name: "Pasta", description: "Step 1:\n\tBoil water\nStep 2:\n\tCook Tomato", ingredients: ["pasta", "cheese", "butter"], time: "12 minutes")
        let salad = Recipe(name: "Salad", description: "Step 1:\n\tWash Ingredients\nStep 2:\n\tCut Tomatoes", ingredients: ["head cabbage", "rocket", "tomato"], time: "10 minutes")
        let fruitSalad = Recipe(name: "Fruit Salad", description: "Step 1:\n\tWash Fruits\nStep 2:\n\tCut Fruits to mouth-sized chunks", ingredients: ["apple", "banana", "orange"], time: "10 minutes")
        let bbqChicken = Recipe(name: "BBQ Chicken", description: "Step 1:\n\tCut up chicken\nStep 2:\n\tMarinate chicken", ingredients: ["rotisserie", "bbq sauce", "saltshaker"], time: "30 minutes")
        
        recipeList = [pizza, pasta, salad, fruitSalad, bbqChicken]
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MatchingRecipeTableViewCell
        let recipe = recipeList[indexPath.row]
        
        cell.update(with: recipe)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let recipeDetailsViewController = segue.destination as! RecipeDetailsViewController
        let indexPath = tableView.indexPathForSelectedRow!
        let selectedRecipe = recipeList[indexPath.row]
        
        recipeDetailsViewController.recipeFromList = selectedRecipe
    }
}
