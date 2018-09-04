//
//  IMSuggestionsDatasource.swift
//  iMovies
//
//  Created by Ricardo Casanova on 05/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

class IMSuggestionsDatasource: NSObject {
    
    public var suggestions: [IMSuggestionViewModel]
    
    public override init() {
        self.suggestions = []
        super.init()
    }
    
}

extension IMSuggestionsDatasource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IMSuggestionTableViewCell.identifier, for: indexPath) as? IMSuggestionTableViewCell else {
            return UITableViewCell()
        }
        
        let viewModel = suggestions[indexPath.row]
        cell.bindWithViewModel(viewModel)
        
        return cell
    }
    
}
