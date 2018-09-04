//
//  IMSuggestionsView.swift
//  iMovies
//
//  Created by Ricardo Casanova on 04/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

class IMSuggestionsView: UIView {
    
    public var suggestions: [IMSuggestionViewModel] = [IMSuggestionViewModel]() {
        didSet {
            datasource?.suggestions = suggestions
            suggestionsTableView?.reloadData()
        }
    }
    
    private var suggestionsTableView: UITableView?
    private var datasource: IMSuggestionsDatasource?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
}

// MARK: - Setup views
extension IMSuggestionsView {
    
    private func setupViews() {
        backgroundColor = .yellow
        
        configureSubviews()
        addSubviews()
    }
    
    private func configureSubviews() {
        suggestionsTableView = UITableView(frame: self.bounds, style: .plain)
        suggestionsTableView?.tableFooterView = UIView()
        suggestionsTableView?.estimatedRowHeight = 44.0
        suggestionsTableView?.rowHeight = 44.0
        
        registerCells()
        setupDatasource()
    }
    
    private func registerCells() {
        suggestionsTableView?.register(IMSuggestionTableViewCell.self, forCellReuseIdentifier: IMSuggestionTableViewCell.identifier)
    }
    
    private func setupDatasource() {
        if let suggestionsTableView = suggestionsTableView {
            datasource = IMSuggestionsDatasource()
            suggestionsTableView.dataSource = datasource
        }
    }
    
}

// MARK: - Layout & constraints
extension IMSuggestionsView {
    
    private func addSubviews() {
        if let suggestionsTableView = suggestionsTableView {
            addSubview(suggestionsTableView)
            addConstraintsWithFormat("H:|[v0]|", views: suggestionsTableView)
            addConstraintsWithFormat("V:|[v0]|", views: suggestionsTableView)
        }
    }
    
}
