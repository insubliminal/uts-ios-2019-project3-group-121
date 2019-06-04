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
    let dataStorage = DataRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        if let savedRecipes = try? dataStorage.loadRecipes() {
            recipeList = savedRecipes
        }
        
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
