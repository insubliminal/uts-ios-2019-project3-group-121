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
    let dataStorage = DataRepository()
    
    @IBOutlet weak var newIngredientLabel: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addedIngredients = try! dataStorage.loadIngredients()
    }
    
    @IBAction func addBtn(_ sender: Any) {
        if newIngredientLabel.text == "" {
            addBtn.isEnabled = false
        }
        guard let newIngredient = newIngredientLabel.text else {return}
        addedIngredients.append(newIngredient)
        try? dataStorage.saveIngredients(addedIngredients)
        
        
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toBack" {
            
            let ingredientListTableViewController = segue.destination as! IngredientsTableViewController
            ingredientListTableViewController.addedIngredients = addedIngredients
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
}
