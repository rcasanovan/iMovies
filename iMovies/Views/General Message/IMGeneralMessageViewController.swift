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
    
    private let titleLabel: UILabel = UILabel()
    private let messageLabel: UILabel = UILabel()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupViews()
        presenter?.viewDidLoad()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

// MARK: - Setup views
extension IMGeneralMessageViewController {
    
    /**
     * SetupViews
     */
    private func setupViews() {
        view.backgroundColor = .black
        
        configureSubviews()
        addSubviews()
    }
    
    /**
     * ConfigureSubviews
     */
    private func configureSubviews() {
        titleLabel.font = UIFont.boldWithSize(size: 40.0)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true
        
        messageLabel.font = UIFont.mediumWithSize(size: 14.0)
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 2
        messageLabel.adjustsFontSizeToFitWidth = true
    }
    
}

// MARK: - Layout & constraints
extension IMGeneralMessageViewController {
    
    /**
     * Internal struct for layout
     */
    private struct Layout {
        
        struct TitleLabel {
            static let top: CGFloat = 68.0
            static let height: CGFloat = 100.0
            static let width: CGFloat = 276.0
            static let leading: CGFloat = 24.0
        }
        
        struct MessageLabel {
            static let top: CGFloat = 25.0
            static let height: CGFloat = 60.0
            static let leading: CGFloat = 24.0
            static let trailing: CGFloat = 24.0
        }
        
    }
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(messageLabel)
        
        // Add validation for iPhone X
        var top: CGFloat = Layout.TitleLabel.top
        if useSafeAreaInsets() {
            top = top + getSafeAreaInsets().top
        }
        
        view.addConstraintsWithFormat("H:|-\(Layout.TitleLabel.leading)-[v0(\(Layout.TitleLabel.width))]", views: titleLabel)
        view.addConstraintsWithFormat("V:|-\(top)-[v0(\(Layout.TitleLabel.height))]", views: titleLabel)
        
        view.addConstraintsWithFormat("H:|-\(Layout.MessageLabel.leading)-[v0]-\(Layout.MessageLabel.trailing)-|", views: messageLabel)
        view.addConstraintsWithFormat("V:[v0]-\(Layout.MessageLabel.top)-[v1(\(Layout.MessageLabel.height))]", views: titleLabel, messageLabel)
    }
    
}

// MARK: - IMGeneralMessageViewInjection
extension IMGeneralMessageViewController: IMGeneralMessageViewInjection {
    
    /**
     * Load information
     *
     * - parameters:
     *      -title: title to show
     *      -message: message to show
     */
    func load(title: String, message: String) {
        titleLabel.text = title
        messageLabel.text = message
    }

}
