//
//  IMSuggestionTableViewCell.swift
//  iMovies
//
//  Created by Ricardo Casanova on 04/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

class IMSuggestionTableViewCell: UITableViewCell {
    
    private var suggestionLabel: UILabel = UILabel()
    
    private var viewModel: IMSuggestionViewModel?
    
    static public var identifier: String {
        return String(describing: self)
    }
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        suggestionLabel.text = ""
    }
    
    public func bindWithViewModel(_ viewModel: IMSuggestionViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - Setup views
extension IMSuggestionTableViewCell {
    
    private func setupViews() {
        backgroundColor = .clear
        
        configureSubviews()
        addSubviews()
    }
    
    private func configureSubviews() {
        suggestionLabel.font = UIFont.mediumWithSize(size: 17.0)
        suggestionLabel.textColor = .white
        suggestionLabel.numberOfLines = 1
        suggestionLabel.backgroundColor = .clear
    }
    
}

// MARK: - Layout & constraints
extension IMSuggestionTableViewCell {
    
    private func addSubviews() {
        addSubview(suggestionLabel)
        
        addConstraintsWithFormat("H:|[v0]|", views: suggestionLabel)
        addConstraintsWithFormat("V:|[v0]|", views: suggestionLabel)
    }
    
}
