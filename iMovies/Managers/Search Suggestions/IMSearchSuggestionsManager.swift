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
    
    public static func saveSuggestion(_ suggestion: String) {
        if suggestionExists(suggestion) { return }
        
        let suggestionModel = IMSearchSuggestion()
        suggestionModel.suggestionId = UUID().uuidString
        suggestionModel.suggestion = suggestion.lowercased()
        suggestionModel.timestamp = NSDate().timeIntervalSince1970
        
        //_ Get the default Realm
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(suggestionModel)
        }
        
        removeOlderSuggestions()
    }
    
    public static func getSuggestions() -> [IMSearchSuggestion] {
        //_ Get the default Realm
        let realm = try! Realm()
        
        //_ Query Realm for all suggestions
        let suggestions = realm.objects(IMSearchSuggestion.self).sorted(byKeyPath: "timestamp", ascending: false)
        return suggestions.toArray(ofType: IMSearchSuggestion.self)
    }
    
    public static func deleteAllSuggestions() {
        let realm = try! Realm()
        let suggestions = realm.objects(IMSearchSuggestion.self)
        
        try! realm.write {
            realm.delete(suggestions)
        }
    }
    
    public static func suggestionExists(_ suggestion: String) -> Bool {
        let realm = try! Realm()
        let suggestions = realm.objects(IMSearchSuggestion.self).filter("suggestion == %@", suggestion.lowercased())
        return suggestions.count == 1
    }
    
}

extension IMSearchSuggestionsManager {
    
    private static func removeOlderSuggestions() {
        let realm = try! Realm()
        let allSuggestions = getSuggestions()
        let firstSuggestions = Array(allSuggestions.prefix(10))
        let suggestionIds = firstSuggestions.map { $0.suggestionId }
        
        // query all objects where the id in not included
        let objectsToDelete = realm.objects(IMSearchSuggestion.self).filter("NOT suggestionId IN %@", suggestionIds)
        
        try! realm.write {
            // and then just remove the set with
            realm.delete(objectsToDelete)
        }
    }
    
}
