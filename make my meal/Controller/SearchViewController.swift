//
//  SearchViewController.swift
//  make my meal
//
//  Created by Insub Lim on 22/5/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTf: UITextField!
    
    var addedIngredients: [String] = []
    let dataStorage = DataRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func addIngredientBtn(_ sender: Any) {
        addedIngredients.append(searchTf.text!)
        try? dataStorage.saveIngredients(addedIngredients)
    }
    
}
