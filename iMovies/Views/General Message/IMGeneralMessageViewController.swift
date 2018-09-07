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
    
    private func setupViews() {
        view.backgroundColor = .black
        
        configureSubviews()
        addSubviews()
    }
    
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
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(messageLabel)
        
        var top: CGFloat = 0.0
        if #available(iOS 11.0, *) {
            if IMUtils.getDeviceType() == .iPhoneX {
                top = 68.0 + view.safeAreaInsets.top
            }
        }
        
        view.addConstraintsWithFormat("H:|-24.0-[v0(276.0)]", views: titleLabel)
        view.addConstraintsWithFormat("V:|-\(top)-[v0(100.0)]", views: titleLabel)
        
        view.addConstraintsWithFormat("H:|-24.0-[v0]-24.0-|", views: messageLabel)
        view.addConstraintsWithFormat("V:[v0]-25.0-[v1(60.0)]", views: titleLabel, messageLabel)
    }
    
}

extension IMGeneralMessageViewController: IMGeneralMessageViewInjection {
    
    func load(title: String, message: String) {
        titleLabel.text = title
        messageLabel.text = message
    }

}
