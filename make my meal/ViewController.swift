//
//  ViewController.swift
//  make my meal
//
//  Created by Insub Lim on 22/5/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var searchedItem = ""
    var relevantRecipes = [String]()
    let recipes = ["Pizza", "Pasta", "Salad", "BBQ Chicken", "Fruit Salad"]
    var recipeSelected = ""
    
    
    override func viewWillAppear(_ animated: Bool) {
        getRelevantItems()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return recipes.count
        return relevantRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecipeTableViewCell
        
        cell.recipeImageView.image = UIImage(named: relevantRecipes[indexPath.row])
        cell.recipeName.text = relevantRecipes[indexPath.row]
        cell.recipeImageView.tag = indexPath.row;
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecipe = relevantRecipes[indexPath.row]
        recipeSelected = selectedRecipe
        print(recipeSelected)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if recipeSelected == "Fruit Salad" {
            return true
        }
        return false
    }
    
    func getRelevantItems() {
        
        for item in recipes {
            if searchedItem.contains(item) {
                relevantRecipes.append(item)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

