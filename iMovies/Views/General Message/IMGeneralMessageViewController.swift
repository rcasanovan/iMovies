//
//  IMReachabilityViewController.swift
//  iMovies
//
//  Created by Ricardo Casanova on 06/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

class IMGeneralMessageViewController: IMBaseViewController {
    
    public var presenter: IMGeneralMessagePresenter?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupViews()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

// MARK: - Setup views
extension IMGeneralMessageViewController {
    
    private func setupViews() {
        view.backgroundColor = .yellow
        
        configureSubviews()
        addSubviews()
    }
    
    private func configureSubviews() {
    }
    
}

// MARK: - Layout & constraints
extension IMGeneralMessageViewController {
    
    private func addSubviews() {
    }
    
}

extension IMGeneralMessageViewController: IMGeneralMessageViewInjection {
    
    func load(title: String, message: String) {
    }

}
