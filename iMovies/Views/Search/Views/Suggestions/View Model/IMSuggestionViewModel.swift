//
//  IMSuggestionViewModel.swift
//  iMovies
//
//  Created by Ricardo Casanova on 04/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

struct IMSuggestionViewModel {
    
    let suggestion: String
    
    init(suggestion: String) {
        self.suggestion = suggestion
    }
    
    /**
     * Get the view models with a IMSearchSuggestion array
     */
    public static func getViewModelsWith(suggestions: [IMSearchSuggestion]) -> [IMSuggestionViewModel] {
        return suggestions.map { getViewModelWith(suggestion: $0) }
    }
    
    /**
     * Get a single view model with a IMSearchSuggestion
     */
    public static func getViewModelWith(suggestion: IMSearchSuggestion) -> IMSuggestionViewModel {
        return IMSuggestionViewModel.init(suggestion: suggestion.suggestion)
    }
    
}
