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
    
    private var moviesContainerView: UIView = UIView()
    private var moviesTableView: UITableView?
    private var datasource: IMSearchDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter?.viewDidLoad()
    }
    
}

// MARK: - Setup views
extension IMSearchViewController {
    
    private func setupViews() {
        view.backgroundColor = .yellow
        
        configureSubviews()
        addSubviews()
    }
    
    private func configureSubviews() {
        
        moviesTableView = UITableView(frame: moviesContainerView.bounds, style: .plain)
        moviesTableView?.delegate = self
        moviesTableView?.tableFooterView = UIView()
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
        view.addSubview(moviesContainerView)
        
        view.addConstraintsWithFormat("H:|[v0]|", views: moviesContainerView)
        view.addConstraintsWithFormat("V:|[v0]|", views: moviesContainerView)
        
        if let moviesTableView = moviesTableView {
            moviesContainerView.addSubview(moviesTableView)
            moviesContainerView.addConstraintsWithFormat("H:|[v0]|", views: moviesTableView)
            moviesContainerView.addConstraintsWithFormat("V:|[v0]|", views: moviesTableView)
        }

    }
    
}

extension IMSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170.0
    }
    
}

extension IMSearchViewController: IMSearchViewInjection {
    
    func loadMovies(_ movies: [IMMovieViewModel]) {
        self.movies = movies
    }
    
}
