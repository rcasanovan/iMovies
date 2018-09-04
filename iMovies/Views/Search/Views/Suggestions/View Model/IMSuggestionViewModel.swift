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
    
    public static func getViewModelsWith(suggestions: [IMSearchSuggestion]) -> [IMSuggestionViewModel] {
        return suggestions.map { getViewModelWith(suggestion: $0) }
    }
    
    public static func getViewModelWith(suggestion: IMSearchSuggestion) -> IMSuggestionViewModel {
        return IMSuggestionViewModel.init(suggestion: suggestion.suggestion)
    }
    
    public static func getDemoViewModels() -> [IMSuggestionViewModel] {
        var suggestions: [IMSuggestionViewModel] = [IMSuggestionViewModel]()
        suggestions.append(IMSuggestionViewModel(suggestion: "batman"))
        suggestions.append(IMSuggestionViewModel(suggestion: "superman"))
        return suggestions
    }
    
}
