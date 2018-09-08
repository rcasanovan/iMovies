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
    private var backgroundLayerImageView: UIVisualEffectView?
    private var posterImageView: UIImageView = UIImageView()
    private var titleLabel: UILabel = UILabel()
    private var releaseDateLabel: UILabel = UILabel()
    private var movieStarRating: EDStarRating = EDStarRating()
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
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImageView.image = nil
        posterImageView.image = nil
        titleLabel.text = ""
        releaseDateLabel.text = ""
        overviewLabel.text = ""
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
    
    /**
     * SetupViews
     */
    private func setupViews() {
        backgroundColor = .clear
        
        configureSubviews()
        addSubviews()
    }
    
    /**
     * ConfigureSubviews
     */
    private func configureSubviews() {
        backgroundImageView.frame = self.bounds
        backgroundImageView.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        backgroundLayerImageView = UIVisualEffectView(effect: blurEffect)
        backgroundLayerImageView?.frame = self.bounds
        backgroundLayerImageView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        posterImageView.frame = CGRect(x: 0.0, y: 0.0, width: 92.0, height: 132.0)
        posterImageView.backgroundColor = .clear
        
        titleLabel.font = UIFont.mediumWithSize(size: 17.0)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.backgroundColor = .clear
        
        releaseDateLabel.font = UIFont.regularWithSize(size: 14.0)
        releaseDateLabel.textColor = .white
        
        movieStarRating.starImage = UIImage(named: "StarRatingEmpty")
        movieStarRating.starHighlightedImage = UIImage(named: "StarRatingFull")
        movieStarRating.maxRating = 5
        movieStarRating.editable = false
        movieStarRating.displayMode = UInt(EDStarRatingDisplayFull)
        movieStarRating.backgroundColor = .clear
        
        overviewLabel.font = UIFont.regularWithSize(size: 15.0)
        overviewLabel.textColor = .white
        overviewLabel.numberOfLines = 0
    }
    
    /**
     * Configure movie information
     */
    private func configureInformation() {
        guard let viewModel = viewModel else {
            return
        }
        titleLabel.text = viewModel.title
        releaseDateLabel.text = viewModel.releaseDate
        movieStarRating.rating = viewModel.rating
        
        guard let overview = viewModel.overview else {
            return
        }
        overviewLabel.text = overview
    }
    
    /**
     * Configure background image
     */
    private func configureBackgroundImage() {
        guard let url = viewModel?.largeUrlImage else {
            return
        }
        backgroundImageView.hnk_setImage(from: url, placeholder: nil, success: { [weak self] (image) in
            guard let `self` = self else { return }

            self.backgroundImageView.contentMode = .redraw
            self.backgroundImageView.clipsToBounds = true
            self.backgroundImageView.image = image
        }) { (error) in
        }
    }
    
    /**
     * Configure poster image
     */
    private func configurePosterImage() {
        guard let url = viewModel?.smallUrlImage else {
            return
        }
        posterImageView.hnk_setImage(from: url, placeholder: nil)
    }
    
}

// MARK: - Layout & constraints
extension IMMovieTableViewCell {
    
    /**
     * Internal struct for layout
     */
    private struct Layout {
        
        struct PosterImageView {
            static let height: CGFloat = 138.0
            static let width: CGFloat = 92.0
            static let leading: CGFloat = 16.0
            static let top: CGFloat = 16.0
            static let bottom: CGFloat = 16.0
        }
        
        struct TitleLabel {
            static let height: CGFloat = 45.0
            static let top: CGFloat = 16.0
            static let leading: CGFloat = 16.0
            static let trailing: CGFloat = 16.0
        }
        
        struct ReleaseDateLabel {
            static let height: CGFloat = 17.0
            static let top: CGFloat = 8.0
            static let leading: CGFloat = 16.0
            static let trailing: CGFloat = 16.0
        }
        
        struct StarRating {
            static let height: CGFloat = 15.0
            static let width: CGFloat = 100.0
            static let top: CGFloat = 8.0
            static let leading: CGFloat = 8.0
        }
        
        struct OverviewLabel {
            static let top: CGFloat = 8.0
            static let bottom: CGFloat = 8.0
            static let leading: CGFloat = 16.0
            static let trailing: CGFloat = 16.0
        }
    }
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        addSubview(backgroundImageView)
        
        if let backgroundLayerImageView = backgroundLayerImageView {
            addSubview(backgroundLayerImageView)
            addConstraintsWithFormat("H:|[v0]|", views: backgroundLayerImageView)
            addConstraintsWithFormat("V:|[v0]|", views: backgroundLayerImageView)
        }
        
        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(releaseDateLabel)
        addSubview(movieStarRating)
        addSubview(overviewLabel)
        
        addConstraintsWithFormat("H:|[v0]|", views: backgroundImageView)
        addConstraintsWithFormat("V:|[v0]|", views: backgroundImageView)
        
        addConstraintsWithFormat("H:|-\(Layout.PosterImageView.leading)-[v0(\(Layout.PosterImageView.width))]", views: posterImageView)
        addConstraintsWithFormat("V:|-\(Layout.PosterImageView.top)-[v0(\(Layout.PosterImageView.height))]->=\(Layout.PosterImageView.bottom)-|", views: posterImageView)
        
        addConstraintsWithFormat("H:[v0]-\(Layout.TitleLabel.leading)-[v1]-\(Layout.TitleLabel.trailing)-|", views: posterImageView, titleLabel)
        addConstraintsWithFormat("V:|-\(Layout.TitleLabel.top)-[v0(\(Layout.TitleLabel.height))]", views: titleLabel)
        
        addConstraintsWithFormat("H:[v0]-\(Layout.ReleaseDateLabel.leading)-[v1]-\(Layout.ReleaseDateLabel.trailing)-|", views: posterImageView, releaseDateLabel)
        addConstraintsWithFormat("V:[v0]-\(Layout.ReleaseDateLabel.top)-[v1(\(Layout.ReleaseDateLabel.height))]", views: titleLabel, releaseDateLabel)
        
        addConstraintsWithFormat("H:[v0]-\(Layout.StarRating.leading)-[v1(\(Layout.StarRating.width))]", views: posterImageView, movieStarRating)
        addConstraintsWithFormat("V:[v0]-\(Layout.StarRating.top)-[v1(\(Layout.StarRating.height))]", views: releaseDateLabel, movieStarRating)
        
        addConstraintsWithFormat("H:[v0]-\(Layout.OverviewLabel.leading)-[v1]-\(Layout.OverviewLabel.trailing)-|", views: posterImageView, overviewLabel)
        addConstraintsWithFormat("V:[v0]-\(Layout.OverviewLabel.top)-[v1]-\(Layout.OverviewLabel.bottom)-|", views: movieStarRating, overviewLabel)
    }
    
}
