//
//  NoDataMessage.swift
//  PopularMovies
//
//  Created by Vivatum on 07/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import Foundation

enum NoDataMessage {
    case noDataFetched
    case noMessage
    case loading
    
    var message: String {
        switch self {
        case .noDataFetched:
            return "data.no.fetched".localized
        case .noMessage:
            return ""
        case .loading:
            return "data.no.loading".localized
        }
    }
}
