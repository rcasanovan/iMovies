//
//  IMMovieTableViewCell.swift
//  iMovies
//
//  Created by Ricardo Casanova on 04/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

class IMMovieTableViewCell: UITableViewCell {
    
    private var backgroundImageView: UIImageView = UIImageView()
    private var backgroundLayerImageView: UIImageView = UIImageView()
    private var posterImageView: UIImageView = UIImageView()
    private var titleLabel: UILabel = UILabel()
    private var releaseDateLabel: UILabel = UILabel()
    private var overviewLabel: UILabel = UILabel()
    
    private var viewModel: IMMovieViewModel?
    
    static public var identifier: String {
        return String(describing: self)
    }
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    public func bindWithViewModel(_ viewModel: IMMovieViewModel) {
        self.viewModel = viewModel
        configureInformation()
        configurePosterImage()
        configureBackgroundImage()
    }
}

// MARK: - Setup views
extension IMMovieTableViewCell {
    
    private func setupViews() {
        backgroundColor = .clear
        
        configureSubviews()
        addSubviews()
    }
    
    private func configureSubviews() {
        backgroundImageView.frame = self.frame
        backgroundImageView.backgroundColor = .clear
        backgroundImageView.clipsToBounds = true
        backgroundImageView.contentMode = .scaleAspectFill
        
        backgroundLayerImageView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        posterImageView.frame = CGRect(x: 0.0, y: 0.0, width: 92.0, height: 132.0)
        posterImageView.backgroundColor = .clear
        
        titleLabel.font = UIFont.mediumWithSize(size: 17.0)
        titleLabel.textColor = .white
        
        releaseDateLabel.font = UIFont.regularWithSize(size: 14.0)
        releaseDateLabel.textColor = .white
        
        overviewLabel.font = UIFont.regularWithSize(size: 15.0)
        overviewLabel.textColor = .white
        overviewLabel.numberOfLines = 0
    }
    
    private func configureInformation() {
        guard let viewModel = viewModel else {
            return
        }
        titleLabel.text = viewModel.title
        releaseDateLabel.text = viewModel.releaseDate
        
        guard let overview = viewModel.overview else {
            return
        }
        overviewLabel.text = overview
    }
    
    private func configureBackgroundImage() {
        guard let url = viewModel?.largeUrlImage else {
            return
        }
        backgroundImageView.hnk_setImage(from: url, placeholder: nil)
    }
    
    private func configurePosterImage() {
        guard let url = viewModel?.smallUrlImage else {
            return
        }
        posterImageView.hnk_setImage(from: url, placeholder: nil)
    }
    
}

// MARK: - Layout & constraints
extension IMMovieTableViewCell {
    
    private func addSubviews() {
        addSubview(backgroundImageView)
        addSubview(backgroundLayerImageView)
        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(releaseDateLabel)
        addSubview(overviewLabel)
        
        addConstraintsWithFormat("H:|[v0]|", views: backgroundImageView)
        addConstraintsWithFormat("V:|[v0]|", views: backgroundImageView)
        
        addConstraintsWithFormat("H:|[v0]|", views: backgroundLayerImageView)
        addConstraintsWithFormat("V:|[v0]|", views: backgroundLayerImageView)
        
        addConstraintsWithFormat("H:|-16.0-[v0(92.0)]", views: posterImageView)
        addConstraintsWithFormat("V:|-16.0-[v0(138.0)]-16.0-|", views: posterImageView)
        
        addConstraintsWithFormat("H:[v0]-16.0-[v1]-16.0-|", views: posterImageView, titleLabel)
        addConstraintsWithFormat("V:|-16.0-[v0(22.0)]", views: titleLabel)
        
        addConstraintsWithFormat("H:[v0]-16.0-[v1]-16.0-|", views: posterImageView, releaseDateLabel)
        addConstraintsWithFormat("V:[v0]-8.0-[v1(17.0)]", views: titleLabel, releaseDateLabel)
        
        addConstraintsWithFormat("H:[v0]-16.0-[v1]-16.0-|", views: posterImageView, overviewLabel)
        addConstraintsWithFormat("V:[v0]-16.0-[v1]-16.0-|", views: releaseDateLabel, overviewLabel)
    }
    
}
