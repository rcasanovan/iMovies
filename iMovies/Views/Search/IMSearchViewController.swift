//
//  IMSearchViewController.swift
//  iMovies
//
//  Created by Ricardo Casanova on 03/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit

class IMSearchViewController: UIViewController {
    
    public var presenter: IMSearchPresenterDelegate?
    
    private var movies: [IMMovieViewModel] = [IMMovieViewModel]() {
        didSet {
            datasource?.movies = movies
            moviesTableView?.reloadData()
        }
    }
    
    private let searchView: IMSearchView = IMSearchView()
    private let moviesContainerView: UIView = UIView()
    private var moviesTableView: UITableView?
    private var datasource: IMSearchDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter?.viewDidLoad()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

// MARK: - Setup views
extension IMSearchViewController {
    
    private func setupViews() {
        view.backgroundColor = .clear
        
        configureSubviews()
        addSubviews()
    }

    private func configureSubviews() {
        moviesTableView = UITableView(frame: moviesContainerView.bounds, style: .plain)
        moviesTableView?.tableFooterView = UIView()
        moviesTableView?.estimatedRowHeight = 170.0
        moviesTableView?.rowHeight = UITableViewAutomaticDimension
        moviesTableView?.invalidateIntrinsicContentSize()
        moviesTableView?.allowsSelection = false
        
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
    
}

// MARK: - Layout & constraints
extension IMSearchViewController {
    
    private func addSubviews() {
        view.addSubview(searchView)
        view.addSubview(moviesContainerView)
        
        view.addConstraintsWithFormat("H:|[v0]|", views: searchView)
        view.addConstraintsWithFormat("V:|[v0(\(searchView.getHeight()))]", views: searchView)
        
        view.addConstraintsWithFormat("H:|[v0]|", views: moviesContainerView)
        view.addConstraintsWithFormat("V:|[v0][v1]|", views: searchView, moviesContainerView)
        
        if let moviesTableView = moviesTableView {
            moviesContainerView.addSubview(moviesTableView)
            moviesContainerView.addConstraintsWithFormat("H:|[v0]|", views: moviesTableView)
            moviesContainerView.addConstraintsWithFormat("V:|[v0]|", views: moviesTableView)
        }
    }
    
}

extension IMSearchViewController: IMSearchViewInjection {
    
    func loadMovies(_ movies: [IMMovieViewModel]) {
        self.movies = movies
    }
    
}
