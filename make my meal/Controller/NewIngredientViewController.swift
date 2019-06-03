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
    var pressedAdd = false
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var newIngredientTextField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addBtn(_ sender: Any) {
        guard let newIngredient = newIngredientTextField.text else {return}
        
        if !ingredientIsInCurrentList(ingredient: newIngredient, ingredientList: addedIngredients) && newIngredientTextField.text != "" {
            addedIngredients.append(newIngredient)
        } 
        
        pressedAdd = true
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindToNewIngredient (segue: UIStoryboardSegue) {}

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if pressedAdd {
            let ingredientViewController = segue.destination as! IngredientsViewController
            
            ingredientViewController.addedIngredients = addedIngredients
        }
        
        else if segue.identifier == "toCamera" {
            let cameraViewController = segue.destination as! CameraViewController
            
            cameraViewController.addedIngredients = addedIngredients
        }
    }
}


