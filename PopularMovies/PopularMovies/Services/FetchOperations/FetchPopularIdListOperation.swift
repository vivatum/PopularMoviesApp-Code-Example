//
//  FetchPopularIdListOperation.swift
//  PopularMovies
//
//  Created by Vivatum on 06/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import Foundation
import CocoaLumberjackSwift

final class FetchPopularIdListOperation: AsyncOperation {
    
    private(set) var idCollection: PopularIdList?
    private var pageRequest: Int
    
    init(page: Int) {
        self.pageRequest = page
    }
    
    override func main() {
        DDLogInfo("Start fetching popular Movie id for page: \(self.pageRequest)")
        self.fetchPopularIdList()
    }
    
    private func fetchPopularIdList() {
        
        guard let requestUrl = URLFactory.moviesPopularRequestURL(self.pageRequest) else {
            let errorMessage = "Can't get request URL"
            DDLogError(errorMessage)
            self.finish()
            return
        }
        
        let fetchService = MovieFetchHelper()
        fetchService.fetchMovieIdList(by: requestUrl) { result in
            switch result {
            case .success(let list):
                self.idCollection = list
                DDLogInfo("Popular movies fetched for PageRequest: \(self.pageRequest), items.count: \(String(describing: self.idCollection?.items.count))")
                self.finish()
            case .failure(let error):
                DDLogError("Can't get idList for PageRequest: \(self.pageRequest). \(error.localizedDescription)")
                self.finish()
            }
        }
    }
}
