//
//  RatingCircle.swift
//  PopularMovies
//
//  Created by Vivatum on 08/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import UIKit

struct Circle {
    let path: UIBezierPath
    let color: UIColor
    let lineWidth: CGFloat
}

struct RatingCircle {
    
    private var center: CGPoint
    private var color: UIColor
    private var radius: CGFloat
    private var lineWidth: CGFloat
    private var voteAngle: CGFloat
    
    private let startAngle: CGFloat = -90.degreesToRadians
    private let endAngle: CGFloat = 270.degreesToRadians
    private let radiusFactor: CGFloat = 0.45
    private let lineFactor: CGFloat = 0.1
    private let subColorAlpha: CGFloat = 0.4
    private let lowRaitingLevel: Int = 50
    
    init(size: CGFloat, vote: Int, center: CGPoint) {
        self.center = center
        self.radius = size * radiusFactor
        self.lineWidth = size * lineFactor
        self.voteAngle = Double(360 * vote / 100 - 90).degreesToRadians
        self.color = vote < lowRaitingLevel ? AppColor.ratingLow : AppColor.ratingHigh
    }
    
    var mainCircle: Circle {
        let circlePath = UIBezierPath(arcCenter: self.center, radius:
            self.radius, startAngle: self.startAngle, endAngle: self.voteAngle, clockwise: true)
        
        return Circle(
            path: circlePath,
            color: self.color,
            lineWidth: self.lineWidth)
    }
    
    var subCircle: Circle {
        let circlePath = UIBezierPath(arcCenter: self.center, radius:
            self.radius, startAngle: self.startAngle, endAngle: self.endAngle, clockwise: true)
        
        return Circle(
            path: circlePath,
            color: self.color.withAlphaComponent(subColorAlpha),
            lineWidth: lineWidth)
    }
}

