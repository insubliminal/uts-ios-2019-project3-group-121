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
<<<<<<< HEAD
=======
    let dataStorage = DataRepository()
>>>>>>> 40708a30bacb4517857fdade163cadc5c63d5427
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
<<<<<<< HEAD
        tableView.reloadData()
=======
        
        if let savedIngredientsList = try? dataStorage.loadIngredients() {
            addedIngredients = savedIngredientsList
        }
        //addedIngredients = try! dataStorage.loadIngredients()
>>>>>>> 40708a30bacb4517857fdade163cadc5c63d5427
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
<<<<<<< HEAD
        addedIngredients.removeAll()
=======
        
        try? dataStorage.saveIngredients(addedIngredients)
>>>>>>> 40708a30bacb4517857fdade163cadc5c63d5427
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
        cell.update(with: ingredient)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            addedIngredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
<<<<<<< HEAD
        }
=======
            try? dataStorage.saveIngredients(addedIngredients)
        } 
>>>>>>> 40708a30bacb4517857fdade163cadc5c63d5427
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
    
    
}
