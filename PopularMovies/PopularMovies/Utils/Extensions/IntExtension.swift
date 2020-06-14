//
//  IntExtension.swift
//  PopularMovies
//
//  Created by Vivatum on 07/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import Foundation

extension Int {
    
    func toDurationString() -> String {
        let space = " "
        let hourString = "time.hour".localized
        let minString = "time.min".localized
        
        let hours = self / 60
        let min = self % 60
        return String(describing: hours) + hourString + space + String(describing: min) + minString
    }
}
