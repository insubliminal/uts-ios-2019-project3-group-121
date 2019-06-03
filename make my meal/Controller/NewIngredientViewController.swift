//
//  NewIngredientViewController.swift
//  make my meal
//
//  Created by Gayun Kim on 2/6/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import UIKit

class NewIngredientViewController: UIViewController {

    var addedIngredients: [String] = []
    
    @IBOutlet weak var newIngredientLabel: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addBtn(_ sender: Any) {
        if newIngredientLabel.text == "" {
            addBtn.isEnabled = false
        }
        guard let newIngredient = newIngredientLabel.text else {return}
        addedIngredients.append(newIngredient)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBack" {

            let ingredientListTableViewController = segue.destination as! IngredientsTableViewController
            ingredientListTableViewController.addedIngredients = addedIngredients
        }
    }
    
}
