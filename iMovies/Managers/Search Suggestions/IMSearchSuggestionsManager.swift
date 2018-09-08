//
//  IMSearchSuggestionsManager.swift
//  iMovies
//
//  Created by Ricardo Casanova on 04/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation
import RealmSwift

class IMSearchSuggestionsManager {
    
    /**
     * Save suggestion
     *
     * - parameters:
     *      -suggestion: suggestion to save
     */
    public static func saveSuggestion(_ suggestion: String) {
        if suggestionExists(suggestion) { return }
        
        // Create a suggestion object
        let suggestionModel = IMSearchSuggestion()
        suggestionModel.suggestionId = UUID().uuidString
        suggestionModel.suggestion = suggestion.lowercased()
        suggestionModel.timestamp = NSDate().timeIntervalSince1970
        
        // Get the default Realm
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(suggestionModel)
        }
        
        //Remove older suggestions
        removeOlderSuggestions()
    }
    
    /**
     * Get all suggestions
     */
    public static func getSuggestions() -> [IMSearchSuggestion] {
        // Get the default Realm
        let realm = try! Realm()
        
        // Query Realm for all suggestions
        // Order criteria -> timestamp
        // Order -> descending
        let suggestions = realm.objects(IMSearchSuggestion.self).sorted(byKeyPath: "timestamp", ascending: false)
        return suggestions.toArray(ofType: IMSearchSuggestion.self)
    }
    
    /**
     * Delete all suggestions
     */
    public static func deleteAllSuggestions() {
        let realm = try! Realm()
        let suggestions = realm.objects(IMSearchSuggestion.self)
        
        try! realm.write {
            realm.delete(suggestions)
        }
    }
    
    /**
     * Validate if suggestion exists in the database
     *
     * - parameters:
     *      -suggestion: suggestion to check
     */
    public static func suggestionExists(_ suggestion: String) -> Bool {
        let realm = try! Realm()
        let suggestions = realm.objects(IMSearchSuggestion.self).filter("suggestion == %@", suggestion.lowercased())
        return suggestions.count == 1
    }
    
}

// MARK: - Private section
extension IMSearchSuggestionsManager {
    
    /**
     * Remove older suggestions
     */
    private static func removeOlderSuggestions() {
        let realm = try! Realm()
        // Get all suggestions
        let allSuggestions = getSuggestions()
        // Get the firt 10 suggestions
        let firstSuggestions = Array(allSuggestions.prefix(10))
        // Get the suggestions ids
        let suggestionIds = firstSuggestions.map { $0.suggestionId }
        
        // Query all objects where the id in not included
        let objectsToDelete = realm.objects(IMSearchSuggestion.self).filter("NOT suggestionId IN %@", suggestionIds)
        
        try! realm.write {
            // And then just remove the set with
            realm.delete(objectsToDelete)
        }
    }
    
}
