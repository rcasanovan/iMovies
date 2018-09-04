//
//  IMSearchView.swift
//  iMovies
//
//  Created by Ricardo Casanova on 04/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

class IMSearchView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    public func getHeight() -> CGFloat {
        return Layout.height
    }
    
}

// MARK: - Setup views
extension IMSearchView {
    
    private func setupViews() {
        backgroundColor = .black
        
        configureSubviews()
        addSubviews()
    }
    
    private func configureSubviews() {
    }
    
}

// MARK: - Layout & constraints
extension IMSearchView {
    
    private struct Layout {
        
        static let height: CGFloat = 46.0
        
    }
    
    private func addSubviews() {
    }
    
}
