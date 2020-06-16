//
//  MoviewDetailsViewController.swift
//  PopularMovies
//
//  Created by Vivatum on 07/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import UIKit
import CocoaLumberjackSwift

final class MoviewDetailsViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var overviewTitleLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var genresTextView: UITextView!
    
    @IBOutlet weak var overviewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var genresHeightConstraint: NSLayoutConstraint!
    
    private var cancelButton: UIBarButtonItem!
    private var panGesture: UIPanGestureRecognizer!
    private let iconSize: CGFloat = 18
    
    private var genresBuilder: GenresTextBuilderProtocol?
    public var movieData: MovieDetails?
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genresBuilder = GenresTextBuilder()
        setupRightNavButton()
        setupViewElements()
        populateView()
    }
    
    // MARK: - Setup View
    
    private func setupRightNavButton() {
        guard let buttonIcon = UIImage(named: "pic_close_button") else {return}
        let buttonSize = iconSize * 2
        let iconInset = iconSize / 2
        
        let button: UIButton = UIButton(type: .custom)
        button.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: buttonSize, height: buttonSize))
        button.setImage(buttonIcon, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: iconInset, left: iconInset, bottom: iconInset, right: iconInset)
        button.addTarget(self, action: #selector(self.dismissDedails), for: .touchUpInside)
        
        cancelButton = UIBarButtonItem(customView: button)
        let currWidth = cancelButton.customView?.widthAnchor.constraint(equalToConstant: buttonSize)
        currWidth?.isActive = true
        let currHeight = cancelButton.customView?.heightAnchor.constraint(equalToConstant: buttonSize)
        currHeight?.isActive = true
        self.navigationItem.setRightBarButton(cancelButton, animated: false)
    }
    
    private func setupViewElements() {
        self.view.backgroundColor = AppColor.detailsBackground
        
        posterImageView.layer.borderWidth = 1.0
        posterImageView.layer.borderColor = AppColor.posterBorder.cgColor
        
        titleLabel.textColor = AppColor.mainText
        titleLabel.font = AppFont.detailsTitle
        
        subtitleLabel.textColor = AppColor.mainText
        subtitleLabel.font = AppFont.detailsSubtitle
        
        overviewTitleLabel.textColor = AppColor.mainText
        overviewTitleLabel.font = AppFont.detailsTitle
        overviewTitleLabel.text = "overview.titile".localized
        
        overviewTextView.backgroundColor = .clear
        overviewTextView.isEditable = false
        overviewTextView.isSelectable = false
        overviewTextView.isScrollEnabled = false
        overviewTextView.isUserInteractionEnabled = false
        
        genresTextView.backgroundColor = .clear
        genresTextView.isEditable = false
        genresTextView.isSelectable = false
        genresTextView.isScrollEnabled = false
        genresTextView.isUserInteractionEnabled = false
    }
    
    // MARK: - IBActions
    
    @objc func dismissDedails() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Populate View
    
    private func populateView() {
        guard let movie = self.movieData else { return }
        posterImageView.setupImageByPath(movie.posterPath)
        titleLabel.text = movie.title
        subtitleLabel.text = movie.getSubtitleText()
        overviewTextView.text = movie.overview
        
        if let genres = movie.genres {
            DispatchQueue.global().sync {
                self.genresBuilder?.getAttributedTextView(with: genres) { result in
                    switch result {
                    case .success(let attrText):
                        DispatchQueue.main.async {
                            self.genresTextView.attributedText = attrText
                        }
                    case .failure(let error):
                        DDLogInfo("Can't create GenreText with error: \(error.localizedDescription)")
                    }
                }
            }
        }
        sizeToFitTextViews()
    }
    
    private func sizeToFitTextViews() {
        DispatchQueue.main.async {
            self.overviewTextView.sizeToFit()
            self.overviewHeightConstraint.constant = self.overviewTextView.frame.height
            self.genresTextView.sizeToFit()
            self.genresHeightConstraint.constant = self.genresTextView.frame.height
            self.scrollView.layoutSubviews()
        }
    }
    
}
