//
//  DataRepository.swift
//  make my meal
//
//  Created by Gayun Kim on 2/6/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import Foundation
struct DataRepository: Codable {
    
    let favoriteRecipesURL: URL
    let recipesURL:URL
    
    enum DataError: Error {
        case notSaved
        case notFound
    }
    
    init() {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        favoriteRecipesURL = documentDirectory.appendingPathComponent("favorite_recipes").appendingPathExtension("json")
        recipesURL = documentDirectory.appendingPathComponent("recipes").appendingPathExtension("json")
    }
    
    func saveFavoriteRecipes(_ favoriteRecipes: [Recipe]) throws {
        if let encodedFavoriteRecipes = try? JSONEncoder().encode(favoriteRecipes) {
            try? encodedFavoriteRecipes.write(to: favoriteRecipesURL, options: .noFileProtection)
        }
    }
    
    func loadFavoriteRecipes() throws -> [Recipe] {
        guard let encodedFavoriteRecipes = try? Data(contentsOf: favoriteRecipesURL) else {throw DataError.notFound}
        
        return try! JSONDecoder().decode([Recipe].self, from: encodedFavoriteRecipes)
    }
    
    func saveRecipes(_ recipes: [Recipe]) throws {
        guard let encodedRecipes = try? JSONEncoder().encode(recipes) else {return}
        try? encodedRecipes.write(to: recipesURL, options: .noFileProtection)
    }
    
    func loadRecipes() throws -> [Recipe] {
        guard let encodedRecipes = try? Data(contentsOf: recipesURL) else {throw DataError.notFound}
        return try! JSONDecoder().decode([Recipe].self, from: encodedRecipes)
    }
}
