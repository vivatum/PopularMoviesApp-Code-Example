//
//  DateExtension.swift
//  PopularMovies
//
//  Created by Vivatum on 05/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import Foundation

extension Date {
    
    func toString(format: DateFormatString) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}
