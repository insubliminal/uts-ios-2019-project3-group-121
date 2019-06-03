//
//  IngredientsTableViewController.swift
//  make my meal
//
//  Created by Gayun Kim on 2/6/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import UIKit

class IngredientsTableViewController: UITableViewController {

    var addedIngredients: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedIngredients.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath) as! IngredientsTableViewCell
        let ingredient = addedIngredients[indexPath.row]
        
        cell.textLabel!.text = ingredient

        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            addedIngredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRecipes" {
            
            let matchingRecipeListTableViewController = segue.destination as! MatchingRecipeListTableViewController
            
            matchingRecipeListTableViewController.addedIngredients = addedIngredients
        }
        
        if segue.identifier == "toNewIngredient" {
            
            let newIngredientsViewController = segue.destination as! NewIngredientViewController
            
            newIngredientsViewController.addedIngredients = addedIngredients
        }
    }
    
    @IBAction func unwindToIngredientsViewController(segue: UIStoryboardSegue) {}
    
}
