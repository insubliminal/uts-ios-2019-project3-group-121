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
    
    
    
    var favoriteRecipes: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteRecipe")
        request.returnsObjectsAsFaults = false
        
        guard let results = try? context.fetch(request) else {return}
        for result in results as! [NSManagedObject] {
            if let recipeName = result.value(forKey: "name") as? String {
                favoriteRecipes.append(recipeName)
            }
            print(favoriteRecipes)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRecipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteRecipeCell", for: indexPath) as! FavoriteRecipeTableViewCell
        
        cell.showsReorderControl = true
        let recipe = favoriteRecipes[indexPath.row]
        cell.update(with: recipe)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteRecipe")
            request.returnsObjectsAsFaults = false
            
            guard let results = try? context.fetch(request) else {return}
            for result in results as! [NSManagedObject] {
                if favoriteRecipes[indexPath.row] == result.value(forKey: "name") as? String {
                    context.delete(result)
                }
            }
            try? context.save()
        }
        
        favoriteRecipes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let movedFavoriteRecipe = favoriteRecipes.remove(at: fromIndexPath.row)
        favoriteRecipes.insert(movedFavoriteRecipe, at: to.row)
        tableView.reloadData()
    }
    
    
    
}

