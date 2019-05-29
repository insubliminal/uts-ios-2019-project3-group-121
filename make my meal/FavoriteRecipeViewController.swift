//
//  FavoriteRecipeViewController.swift
//  make my meal
//
//  Created by Gayun Kim on 28/5/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import UIKit

class FavoriteRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    
    var favoriteRecipes:[Recipe] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteRecipeCell", for: indexPath) as! FavoriteRecipeTableViewCell
        
        cell.favoriteRecipeImage.image = UIImage(named: favoriteRecipes[indexPath.row].name)
        cell.favoriteRecipeName.text = favoriteRecipes[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favoriteRecipes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
     func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let movedFavoriteRecipe = favoriteRecipes.remove(at: fromIndexPath.row)
        favoriteRecipes.insert(movedFavoriteRecipe, at: to.row)
        tableView.reloadData()
    }
    



    

}
