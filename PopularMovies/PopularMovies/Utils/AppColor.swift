//
//  AppColor.swift
//  PopularMovies
//
//  Created by Vivatum on 05/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import class UIKit.UIColor

struct AppColor {
    
    static let mainBackground = UIColor(red: (33/255.0), green: (33/255.0), blue: (33/255.0), alpha: 1)
    static let mainText = UIColor(red: (205/255.0), green: (205/255.0), blue: (205/255.0), alpha: 1)
    
    static let sectionHeaderText = UIColor(red: (252/255.0), green: (208/255.0), blue: (82/255.0), alpha: 1)
    static let sectionHeader = UIColor(red: (64/255.0), green: (64/255.0), blue: (64/255.0), alpha: 1)
    static let posterBorder = UIColor(red: (130/255.0), green: (130/255.0), blue: (130/255.0), alpha: 1)
    
    static let ratingHigh = UIColor(red: (31/255.0), green: (211/255.0), blue: (123/255.0), alpha: 1)
    static let ratingLow = UIColor(red: (213/255.0), green: (217/255.0), blue: (47/255.0), alpha: 1)
    static let ratingText = UIColor(red: (240/255.0), green: (240/255.0), blue: (240/255.0), alpha: 1)
    
    static let detailsBackground = UIColor.black.withAlphaComponent(0.82)
    
    static let genreBackground = UIColor(red: (255/255.0), green: (255/255.0), blue: (255/255.0), alpha: 1)
    static let genreText = UIColor(red: (33/255.0), green: (33/255.0), blue: (33/255.0), alpha: 1)
    
    static let noDataMessage = UIColor.gray
}
