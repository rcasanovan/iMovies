//
//  IMSearchViewController.swift
//  iMovies
//
//  Created by Ricardo Casanova on 03/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit

class IMSearchViewController: IMBaseViewController {
    
    public var presenter: IMSearchPresenterDelegate?
    
    private var movies: [IMMovieViewModel] = [IMMovieViewModel]() {
        didSet {
            datasource?.movies = movies
            moviesTableView?.reloadData()
            isLoadingNextPage = false
        }
    }
    
    private let searchView: IMSearchView = IMSearchView()
    private let totalResultsView: IMTotalResultsView = IMTotalResultsView()
    private let moviesContainerView: UIView = UIView()
    private var moviesTableView: UITableView?
    private var datasource: IMSearchDataSource?
    private let suggestionsView = IMSuggestionsView()
    private var suggestionsViewBottomConstraint: NSLayoutConstraint?
    
    private var isLoadingNextPage: Bool = false
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addObservers()
        setupViews()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

// MARK: - Setup views
extension IMSearchViewController {
    
    private func setupViews() {
        view.backgroundColor = .black
        
        configureSubviews()
        addSubviews()
        showSuggestions(show: false, height: 0.0, animated: false)
    }

    private func configureSubviews() {
        searchView.delegate = self
        
        suggestionsView.delegate = self
        
        moviesTableView = UITableView(frame: moviesContainerView.bounds, style: .plain)
        moviesTableView?.tableFooterView = UIView()
        moviesTableView?.estimatedRowHeight = 193.0
        moviesTableView?.rowHeight = UITableViewAutomaticDimension
        moviesTableView?.invalidateIntrinsicContentSize()
        moviesTableView?.allowsSelection = false
        moviesTableView?.backgroundColor = .black
        moviesTableView?.delegate = self
        
        registerCells()
        setupDatasource()
    }
    
    private func registerCells() {
        moviesTableView?.register(IMMovieTableViewCell.self, forCellReuseIdentifier: IMMovieTableViewCell.identifier)
    }
    
    private func setupDatasource() {
        if let moviesTableView = moviesTableView {
            datasource = IMSearchDataSource()
            moviesTableView.dataSource = datasource
        }
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeAppear), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(reachabilityStatusChanged), name: NSNotification.Name.FXReachabilityStatusDidChange, object: nil)
    }
    
}

extension IMSearchViewController {
    
    @objc private func keyboardWillBeAppear(notification: NSNotification) {
        guard let info:[AnyHashable:Any] = notification.userInfo,
            let keyboardSize:CGSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size else { return }
        presenter?.getSuggestions()
        showSuggestions(show: true, height: -keyboardSize.height, animated: true)
    }
    
    @objc private func keyboardWillBeHidden(notification: NSNotification) {
        showSuggestions(show: false, height: 0.0, animated: true)
    }
    
    @objc private func reachabilityStatusChanged() {
        presenter?.reachabilityStatusChanged()
    }
    
}

// MARK: - Layout & constraints
extension IMSearchViewController {
    
    private func addSubviews() {
        view.addSubview(searchView)
        view.addSubview(totalResultsView)
        view.addSubview(moviesContainerView)
        view.addSubview(suggestionsView)
        
        var top: CGFloat = 0.0
        var bottom: CGFloat = 0.0
        if #available(iOS 11.0, *) {
            if IMUtils.getDeviceType() == .iPhoneX {
                top = view.safeAreaInsets.top
                bottom = view.safeAreaInsets.bottom
            }
        }
        
        
        view.addConstraintsWithFormat("H:|[v0]|", views: searchView)
        view.addConstraintsWithFormat("V:|-\(top)-[v0(\(searchView.getHeight()))]", views: searchView)
        
        view.addConstraintsWithFormat("H:|[v0]|", views: totalResultsView)
        view.addConstraintsWithFormat("V:[v0][v1(\(totalResultsView.getHeight()))]", views: searchView, totalResultsView)
        
        view.addConstraintsWithFormat("H:|[v0]|", views: moviesContainerView)
        view.addConstraintsWithFormat("V:[v0][v1]-\(bottom)-|", views: totalResultsView, moviesContainerView)
        
        if let moviesTableView = moviesTableView {
            moviesContainerView.addSubview(moviesTableView)
            moviesContainerView.addConstraintsWithFormat("H:|[v0]|", views: moviesTableView)
            moviesContainerView.addConstraintsWithFormat("V:|[v0]|", views: moviesTableView)
        }
        
        view.addConstraintsWithFormat("H:|[v0]|", views: suggestionsView)
        view.addConstraintsWithFormat("V:[v0][v1]", views: searchView, suggestionsView)
        let suggestionsViewBottomConstraint = NSLayoutConstraint(item: suggestionsView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        view.addConstraint(suggestionsViewBottomConstraint)
        self.suggestionsViewBottomConstraint = suggestionsViewBottomConstraint
    }
    
    private func showSuggestions(show: Bool, height: CGFloat, animated: Bool) {
        let animateDuration = animated ? 0.25 : 0;
        suggestionsViewBottomConstraint?.constant = height
        suggestionsView.isHidden = !show
        UIView.animate(withDuration: animateDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
}

extension IMSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let position = Int(((75.0 * Double(movies.count - 1)) / 100.0))
        
        if !self.isLoadingNextPage && indexPath.item == position {
            self.isLoadingNextPage = true
            presenter?.loadNextPage()
        }
    }
    
}

extension IMSearchViewController: IMSearchViewDelegate {
    
    func searchButtonPressedWithSearch(search: String?) {
        guard let search = search else {
            return
        }
        presenter?.searchMovie(search)
    }
    
}

extension IMSearchViewController: IMSuggestionsViewDelegate {
    
    func suggestionSelectedAt(index: NSInteger) {
        showSuggestions(show: false, height: 0.0, animated: false)
        searchView.hideKeyboard()
        presenter?.suggestionSelectedAt(index: index)
    }
    
}

extension IMSearchViewController: IMSearchViewInjection {
    
    func loadMovies(_ movies: [IMMovieViewModel], fromBeginning: Bool, totalResults: UInt) {
        if fromBeginning {
            // TODO: Scroll to top automatically
        }
        self.movies = movies
        totalResultsView.bindWithText("Total movies: \(totalResults)")
    }
    
    func loadSuggestions(_ suggestions: [IMSuggestionViewModel]) {
        suggestionsView.suggestions = suggestions
    }
    
    func showProgress(_ show: Bool) {
        showLoader(show)
    }
    
    func showMessageWith(title: String, message: String, actionTitle: String) {
        showAlertWith(title: title, message: message, actionTitle: actionTitle)
    }
    
}
