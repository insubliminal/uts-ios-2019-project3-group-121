//
//  IngredientsViewController.swift
//  make my meal
//
//  Created by Gayun Kim on 3/6/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import UIKit

class IngredientsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var addedIngredients: [String] = []
    
    @IBOutlet weak var ingredientTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientTableView.delegate = self
        ingredientTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ingredientTableView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        addedIngredients.removeAll()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        
        let ingredient = addedIngredients[indexPath.row]
        cell.textLabel?.text = ingredient
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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