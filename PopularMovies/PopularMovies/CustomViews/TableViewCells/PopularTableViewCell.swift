//
//  PopularTableViewCell.swift
//  PopularMovies
//
//  Created by Vivatum on 07/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import UIKit

public struct MovieDetailsUIId {
    static let posterImageView = "poster_image_view"
    static let titleLabel = "titile_label"
    static let dateLabel = "date_label"
    static let runtimeLabel = "runtime_Label"
    static let ratingView = "rating_Label"
    static let customSeparatorView = "custom_Separator_View"
}

final class PopularTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var customSeparatorView: UIView!
    
    var details: MovieDetails? {
        didSet {
           populateViewElements()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        posterImageView.layer.borderWidth = 1.0
        posterImageView.layer.borderColor = AppColor.posterBorder.cgColor
        posterImageView.accessibilityIdentifier = MovieDetailsUIId.posterImageView
        
        ratingView.makeRoundView()
        ratingView.isAccessibilityElement = true
        ratingView.accessibilityIdentifier = MovieDetailsUIId.ratingView
        
        titleLabel.textColor = AppColor.mainText
        titleLabel.font = AppFont.listTitle
        titleLabel.accessibilityIdentifier = MovieDetailsUIId.titleLabel
        
        dateLabel.textColor = AppColor.mainText
        dateLabel.font = AppFont.listSubtitle
        dateLabel.accessibilityIdentifier = MovieDetailsUIId.dateLabel
        
        runtimeLabel.textColor = AppColor.mainText
        runtimeLabel.font = AppFont.listSubtitle
        runtimeLabel.accessibilityIdentifier = MovieDetailsUIId.runtimeLabel
        
        backgroundColor = AppColor.mainBackground
        customSeparatorView.backgroundColor = AppColor.sectionHeader
        customSeparatorView.isAccessibilityElement = true
        customSeparatorView.accessibilityIdentifier = MovieDetailsUIId.customSeparatorView
    }

    private func populateViewElements() {
        guard let movie = self.details else { return }
        posterImageView.setupImageByPath(movie.posterPath)
        titleLabel.text = movie.title
        dateLabel.text = movie.releaseDate?.toString(format: .fullDate)
        runtimeLabel.text = movie.runtime?.toDurationString()
        ratingView.rating = movie.vote
    }
    
}

