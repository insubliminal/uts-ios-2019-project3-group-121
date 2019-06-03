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
    var pressedScan = false
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var newIngredientTextField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addBtn(_ sender: Any) {
        
        guard let newIngredient = newIngredientTextField.text else {return}
        
        if addedIngredients.contains(newIngredient) {
            addBtn.isEnabled = false
        }
        
        addedIngredients.append(newIngredient)
        pressedAdd = true
    }
    @IBAction func scanBtn(_ sender: Any) {
        pressedScan = true
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if pressedAdd {
            let ingredientViewController = segue.destination as! IngredientsViewController
            
            ingredientViewController.addedIngredients = addedIngredients
        }
        
        if pressedScan {
            let ingredientViewController = segue.destination as! CameraViewController
            
            ingredientViewController.addedIngredients = addedIngredients
        }
    }
    
    @IBAction func unwindToNewIngredient (segue: UIStoryboardSegue) {}
}


