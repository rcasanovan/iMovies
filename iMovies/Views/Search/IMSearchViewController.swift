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
    
    /**
     * SetupViews
     */
    private func setupViews() {
        view.backgroundColor = .black
        
        configureSubviews()
        addSubviews()
        showSuggestions(show: false, height: 0.0, animated: false)
    }

    /**
     * ConfigureSubviews
     */
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
    
    /**
     * Register all the cells we need
     */
    private func registerCells() {
        moviesTableView?.register(IMMovieTableViewCell.self, forCellReuseIdentifier: IMMovieTableViewCell.identifier)
    }
    
    /**
     * Setup datasource for the movies table view
     */
    private func setupDatasource() {
        if let moviesTableView = moviesTableView {
            datasource = IMSearchDataSource()
            moviesTableView.dataSource = datasource
        }
    }
    
    /**
     * Add observers to the view
     */
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeAppear), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: .UIKeyboardWillHide, object: nil)
    }
    
}

// MARK: - Keyboard actions
extension IMSearchViewController {
    
    /**
     * Control the keyboard will appear action
     *
     * - parameters:
     *      -notification: notification from the keyboard
     */
    @objc private func keyboardWillBeAppear(notification: NSNotification) {
        guard let info:[AnyHashable:Any] = notification.userInfo,
            let keyboardSize:CGSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size else { return }
        presenter?.getSuggestions()
        showSuggestions(show: true, height: -keyboardSize.height, animated: true)
    }
    
    /**
     * Control the keyboard will be hidden action
     *
     * - parameters:
     *      -notification: notification from the keyboard
     */
    @objc private func keyboardWillBeHidden(notification: NSNotification) {
        showSuggestions(show: false, height: 0.0, animated: true)
    }
    
}

// MARK: - Layout & constraints
extension IMSearchViewController {
    
    /**
     * Internal struct for layout
     */
    private struct Layout {
        
        struct Scroll {
            static let percentagePosition: Double = 75.0
        }
        
    }
    
    /**
     * Internal struct for animation
     */
    private struct Animation {
        
        static let animationDuration: TimeInterval = 0.25
        
    }
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        view.addSubview(searchView)
        view.addSubview(totalResultsView)
        view.addSubview(moviesContainerView)
        view.addSubview(suggestionsView)
        
        // Add validation for iPhone X
        var top: CGFloat = 0.0
        var bottom: CGFloat = 0.0
        if #available(iOS 11.0, *) {
            // If we´re running iOS 11 && device type == iPhone X
            // -> use the save area insets
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
    
    /**
     * Show suggestions
     *
     * - parameters:
     *      -show: show / hide the suggestions
     *      -height: the height for the suggestions content
     *      -animated: show / hide suggestions with animation or not
     */
    private func showSuggestions(show: Bool, height: CGFloat, animated: Bool) {
        let animateDuration = animated ? Animation.animationDuration : 0;
        suggestionsViewBottomConstraint?.constant = height
        suggestionsView.isHidden = !show
        UIView.animate(withDuration: animateDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    /**
     * Scroll to top
     */
    private func scrollToTop() {
        moviesTableView?.setContentOffset(.zero, animated: false)
    }
    
}

// MARK: - UITableViewDelegate
extension IMSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Get the position for a percentage of the scrolling
        // In this case we got the positions for the 75%
        let position = Int(((Layout.Scroll.percentagePosition * Double(movies.count - 1)) / 100.0))
        
        // if we're not loading a next page && we´re in the 75% position
        if !self.isLoadingNextPage && indexPath.item == position {
            // Change the value -> We're loading the next page
            self.isLoadingNextPage = true
            // Call the presenter
            presenter?.loadNextPage()
        }
    }
    
}

// MARK: - IMSearchViewDelegate
extension IMSearchViewController: IMSearchViewDelegate {
    
    func searchButtonPressedWithSearch(search: String?) {
        guard let search = search else {
            return
        }
        presenter?.searchMovie(search)
    }
    
}

// MARK: - IMSuggestionsViewDelegate
extension IMSearchViewController: IMSuggestionsViewDelegate {
    
    func suggestionSelectedAt(index: NSInteger) {
        showSuggestions(show: false, height: 0.0, animated: false)
        searchView.hideKeyboard()
        presenter?.suggestionSelectedAt(index: index)
    }
    
}

// MARK: - IMSearchViewInjection
extension IMSearchViewController: IMSearchViewInjection {
    
    /**
     * Load the movies in the UI
     *
     * - parameters:
     *      -movies: movies to be loaded
     *      -fromBeginning: show the fist page results or not
     *      -totalResults: total results for the search
     */
    func loadMovies(_ movies: [IMMovieViewModel], fromBeginning: Bool, totalResults: UInt) {
        // Are we loading the movies from the beginning? -> scroll to top
        if fromBeginning {
            scrollToTop()
        }
        self.movies = movies
        totalResultsView.isHidden = totalResults == 0
        totalResultsView.bindWithText("Total movies: \(totalResults)")
    }
    
    /**
     * Load suggestions in the UI
     *
     * - parameters:
     *      -suggestions: all suggestions to load
     */
    func loadSuggestions(_ suggestions: [IMSuggestionViewModel]) {
        suggestionsView.suggestions = suggestions
    }
    
    /**
     * Show progress
     *
     * - parameters:
     *      -show: show progress or not
     */
    func showProgress(_ show: Bool) {
        showLoader(show)
    }
    
    /**
     * Show alert
     *
     * - parameters:
     *      -title: title for the message
     *      -message: message to show
     *      -actionTitle: action title for the alert
     */
    func showMessageWith(title: String, message: String, actionTitle: String) {
        showAlertWith(title: title, message: message, actionTitle: actionTitle)
    }
    
}
