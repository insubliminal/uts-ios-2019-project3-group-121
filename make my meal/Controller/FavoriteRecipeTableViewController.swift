//
//  FavoriteRecipeTableViewController.swift
//  make my meal
//
//  Created by Gayun Kim on 29/5/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import UIKit
import CoreData

class FavoriteRecipeTableViewController: UITableViewController {
    
    var favoriteList: [Recipe] = []
    
    let dataStorage = DataRepository()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let savedFavoriteList = try? dataStorage.loadFavoriteRecipes() {
            favoriteList = savedFavoriteList
        }
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteRecipeCell", for: indexPath) as! FavoriteRecipeTableViewCell
        
        cell.showsReorderControl = true
        
        let recipe = favoriteList[indexPath.row]
        
        cell.update(with: recipe)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favoriteList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            try? dataStorage.saveFavoriteRecipes(favoriteList)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedFavoriteRecipe = favoriteList.remove(at: fromIndexPath.row)
        
        favoriteList.insert(movedFavoriteRecipe, at: to.row)
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toDetails" else {return}
        
        let indexPath = tableView.indexPathForSelectedRow!
        let selectedFavoriteRecipe = favoriteList[indexPath.row]
        let recipeDetailsViewController = segue.destination as! RecipeDetailsViewController
        
        recipeDetailsViewController.recipeFromList = selectedFavoriteRecipe
    }
}
