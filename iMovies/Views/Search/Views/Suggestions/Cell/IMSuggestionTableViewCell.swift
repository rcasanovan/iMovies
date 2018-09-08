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
    
    /**
     * Bind component
     *
     * - parameters:
     *      -viewModel: IMSuggestionViewModel
     */
    public func bindWithViewModel(_ viewModel: IMSuggestionViewModel) {
        suggestionLabel.text = viewModel.suggestion
    }
}

// MARK: - Setup views
extension IMSuggestionTableViewCell {
    
    /**
     * SetupViews
     */
    private func setupViews() {
        backgroundColor = .clear
        
        configureSubviews()
        addSubviews()
    }
    
    /**
     * ConfigureSubviews
     */
    private func configureSubviews() {
        suggestionLabel.font = UIFont.mediumWithSize(size: 17.0)
        suggestionLabel.textColor = .black
        suggestionLabel.numberOfLines = 1
        suggestionLabel.backgroundColor = .clear
    }
    
}

// MARK: - Layout & constraints
extension IMSuggestionTableViewCell {
    
    /**
     * Internal struct for layout
     */
    private struct Layout {
        
        struct SuggestionsLabel {
            static let leading: CGFloat = 16.0
            static let trailing: CGFloat = 16.0
        }
        
    }
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        addSubview(suggestionLabel)
        
        addConstraintsWithFormat("H:|-\(Layout.SuggestionsLabel.leading)-[v0]-\(Layout.SuggestionsLabel.trailing)-|", views: suggestionLabel)
        addConstraintsWithFormat("V:|[v0]|", views: suggestionLabel)
    }
    
}
