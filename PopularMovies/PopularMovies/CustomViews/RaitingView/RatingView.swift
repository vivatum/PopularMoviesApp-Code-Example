//
//  RatingView.swift
//  PopularMovies
//
//  Created by Vivatum on 08/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import UIKit
import CocoaLumberjackSwift

final class RatingView: UIView {
    
    @IBOutlet var ratingView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
    private let percent = "%"
    
    private let mainCircleLayer = CAShapeLayer()
    private let subCircleLayer = CAShapeLayer()
    
    public var rating: Int? {
        didSet {
            setRating()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    private func loadViewFromNib() {
        Bundle.main.loadNibNamed("RatingView", owner: self, options: nil)
        addSubview(ratingView)
        ratingView.frame = self.bounds
        ratingView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        ratingView.backgroundColor = AppColor.mainBackground
        
        self.numberLabel.textColor = AppColor.ratingText
        self.numberLabel.font = AppFont.raitingNumber
        
        self.percentLabel.textColor = AppColor.ratingText
        self.percentLabel.font = AppFont.raitingPercent
    }
    
    private func setRating() {
        guard let vote = self.rating else { return }
        self.percentLabel.text = percent
        self.numberLabel.text = String(describing: vote)
        drawRatingCircle(vote)
    }
    
    private func drawRatingCircle(_ vote: Int) {
        let circle = RatingCircle(size: self.bounds.width, vote: vote, center: ratingView.center)
        drawCircle(subCircleLayer, circle.subCircle)
        drawCircle(mainCircleLayer, circle.mainCircle)
    }
    
    private func drawCircle(_ layer: CAShapeLayer, _ circle: Circle) {
        layer.path = circle.path.cgPath
        layer.strokeColor = circle.color.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = circle.lineWidth
        ratingView.layer.addSublayer(layer)
    }
 
}
