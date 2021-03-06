//
//  IMTotalResultsView.swift
//  iMovies
//
//  Created by Ricardo Casanova on 06/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

class IMTotalResultsView: UIView {
    
    private let totalResultsLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    /**
     * Get component's height
     */
    public func getHeight() -> CGFloat {
        return Layout.height
    }
    
}

// MARK: - Setup views
extension IMTotalResultsView {
    
    /**
     * SetupViews
     */
    private func setupViews() {
        backgroundColor = .black
        
        configureSubviews()
        addSubviews()
    }
    
    /**
     * ConfigureSubviews
     */
    private func configureSubviews() {
        totalResultsLabel.font = UIFont.boldWithSize(size: 14.0)
        totalResultsLabel.textAlignment = .center
        totalResultsLabel.textColor = .white
    }
    
    /**
     * Bind component
     *
     * - parameters:
     *      -text: text for the total results
     */
    public func bindWithText(_ text: String) {
        totalResultsLabel.text = text
    }
    
}

// MARK: - Layout & constraints
extension IMTotalResultsView {
    
    /**
     * Internal struct for layout
     */
    private struct Layout {
        
        static let height: CGFloat = 30.0
        
    }
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        addSubview(totalResultsLabel)
        
        addConstraintsWithFormat("H:|[v0]|", views: totalResultsLabel)
        addConstraintsWithFormat("V:|[v0]|", views: totalResultsLabel)
    }
    
}
