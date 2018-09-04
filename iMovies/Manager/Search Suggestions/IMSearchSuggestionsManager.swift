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
        let suggestionModel = IMSearchSuggestion()
        suggestionModel.suggestion = suggestion
        suggestionModel.timestamp = NSDate().timeIntervalSince1970
        
        //_ Get the default Realm
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(suggestionModel)
        }
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
}
