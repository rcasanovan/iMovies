//
//  IMSuggestionsView.swift
//  iMovies
//
//  Created by Ricardo Casanova on 04/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

protocol IMSuggestionsViewDelegate {
    func suggestionSelectedAt(index: NSInteger)
}

class IMSuggestionsView: UIView {
    
    public var delegate: IMSuggestionsViewDelegate?
    
    public var suggestions: [IMSuggestionViewModel] = [IMSuggestionViewModel]() {
        didSet {
            suggestionsTableView?.isHidden = suggestions.isEmpty
            noSuggestionsLabel.isHidden = !suggestions.isEmpty
            datasource?.suggestions = suggestions
            suggestionsTableView?.reloadData()
        }
    }
    
    private let noSuggestionsLabel = UILabel()
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
        backgroundColor = .white
        
        configureSubviews()
        addSubviews()
    }
    
    private func configureSubviews() {
        suggestionsTableView = UITableView(frame: self.bounds, style: .plain)
        suggestionsTableView?.tableFooterView = UIView()
        suggestionsTableView?.estimatedRowHeight = 44.0
        suggestionsTableView?.rowHeight = 44.0
        suggestionsTableView?.delegate = self
        
        registerCells()
        setupDatasource()
        
        noSuggestionsLabel.font = UIFont.mediumWithSize(size: 14.0)
        noSuggestionsLabel.textColor = .lightGray
        noSuggestionsLabel.textAlignment = .center
        noSuggestionsLabel.text = "No suggestions"
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
    
    private struct Layout {
        
        struct NoSuggestionsLabel {
            static let height: CGFloat = 17.0
        }
        
    }
    
    private func addSubviews() {
        addSubview(noSuggestionsLabel)
        
        addConstraintsWithFormat("H:|[v0]|", views: noSuggestionsLabel)
        addConstraintsWithFormat("V:[v0(\(Layout.NoSuggestionsLabel.height))]", views: noSuggestionsLabel)
        let xConstraint = NSLayoutConstraint(item: noSuggestionsLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let yConstraint = NSLayoutConstraint(item: noSuggestionsLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        addConstraint(xConstraint)
        addConstraint(yConstraint)
        
        if let suggestionsTableView = suggestionsTableView {
            addSubview(suggestionsTableView)
            addConstraintsWithFormat("H:|[v0]|", views: suggestionsTableView)
            addConstraintsWithFormat("V:|[v0]|", views: suggestionsTableView)
        }
    }
    
}

extension IMSuggestionsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.suggestionSelectedAt(index: indexPath.row)
    }
    
}
