//
//  IMSearchView.swift
//  iMovies
//
//  Created by Ricardo Casanova on 04/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

protocol IMSearchViewDelegate {
    func searchButtonPressedWithSearch(search: String?)
}

class IMSearchView: UIView {
    
    public var delegate: IMSearchViewDelegate?
    
    private let searchContainerView: UIView = UIView()
    private var searchContainerViewTrailingConstraint: NSLayoutConstraint?
    
    private let searchBar: UISearchBar = UISearchBar()
    
    private let cancelButton: UIButton = UIButton(type: .custom)
    private var cancelButtonWidthConstraint: NSLayoutConstraint?
    
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
    
    public func hideKeyboard() {
        searchBar.resignFirstResponder()
        showCancel(show: false, animated: true)
    }
    
}

// MARK: - Setup views
extension IMSearchView {
    
    private func setupViews() {
        backgroundColor = .black
        
        configureSubviews()
        addSubviews()
        showCancel(show: false, animated: false)
    }
    
    private func configureSubviews() {
        searchContainerView.backgroundColor = .clear

        searchBar.backgroundColor = .clear
        searchBar.barTintColor = .clear
        searchBar.delegate = self
        
        cancelButton.setBackgroundImage(UIImage(named: "CancelButton"), for: .normal)
        cancelButton.setBackgroundImage(UIImage(named: "CancelButtonPressed"), for: .selected)
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
    }
    
}

// MARK: - Layout & constraints
extension IMSearchView {
    
    private struct Layout {
        
        static let height: CGFloat = 46.0
        
    }
    
    private func addSubviews() {
        addSubview(searchContainerView)
        addSubview(cancelButton)
        searchContainerView.addSubview(searchBar)
        
        addConstraintsWithFormat("H:|-7.0-[v0]", views: searchContainerView)
        let searchContainerViewTrailingConstraint = NSLayoutConstraint(item: searchContainerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        addConstraint(searchContainerViewTrailingConstraint)
        self.searchContainerViewTrailingConstraint = searchContainerViewTrailingConstraint
        addConstraintsWithFormat("V:|[v0]|", views: searchContainerView)
        
        addConstraintsWithFormat("H:[v0(93.0)]-15.0-|", views: cancelButton)
        addConstraintsWithFormat("V:|-7.0-[v0]", views: cancelButton)
        let cancelButtonWidthConstraint = NSLayoutConstraint(item: cancelButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 0.0)
        addConstraint(cancelButtonWidthConstraint)
        self.cancelButtonWidthConstraint = cancelButtonWidthConstraint
        
        searchContainerView.addConstraintsWithFormat("H:|[v0]|", views: searchBar)
        searchContainerView.addConstraintsWithFormat("V:|[v0]|", views: searchBar)
    }
    
    private func showCancel(show: Bool, animated: Bool) {
        let animateDuration = animated ? 0.45 : 0;
        cancelButtonWidthConstraint?.constant = show ? 93.0 : 0.0;
        searchContainerViewTrailingConstraint?.constant = show ? -115.0 : -7.0;
        
        UIView.animate(withDuration: animateDuration) {
            self.layoutIfNeeded()
        }
    }
    
}

extension IMSearchView: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        showCancel(show: true, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        delegate?.searchButtonPressedWithSearch(search: searchBar.text)
    }
    
}

extension IMSearchView {
    
    @objc private func cancelButtonPressed() {
        showCancel(show: false, animated: true)
        searchBar.resignFirstResponder()
    }
    
}
