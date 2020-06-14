//
//  UIViewExtension.swift
//  PopularMovies
//
//  Created by Vivatum on 08/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import UIKit

extension UIView {

    func roundCorners(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func makeRoundView() {
        roundCorners(self.frame.height / 2)
    }
    
}
