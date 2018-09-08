//
//  IMSearchDataSource.swift
//  iMovies
//
//  Created by Ricardo Casanova on 04/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

class IMSearchDataSource: NSObject {
    
    // Movies to inject to the table view
    public var movies: [IMMovieViewModel]
    
    public override init() {
        self.movies = []
        super.init()
    }
    
}

// MARK: - UITableViewDataSource
extension IMSearchDataSource: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IMMovieTableViewCell.identifier, for: indexPath) as? IMMovieTableViewCell else {
            return UITableViewCell()
        }
        
        // Get the view model and bind the cell with the information
        let viewModel = movies[indexPath.row]
        cell.bindWithViewModel(viewModel)
        
        return cell
    }
        
}
