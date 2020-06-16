//
//  DoubleExtension.swift
//  PopularMovies
//
//  Created by Vivatum on 08/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import UIKit

extension Double {
    
    var degreesToRadians: CGFloat {
        return CGFloat(self) * CGFloat(Double.pi) / 180.0
    }
}
