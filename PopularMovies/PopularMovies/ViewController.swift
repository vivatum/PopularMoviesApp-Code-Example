//
//  ViewController.swift
//  PopularMovies
//
//  Created by Volodymyr Vozniak on 14/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import UIKit
import CocoaLumberjackSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DDLogInfo("### ViewController start")
        fetchPlayingNowMovies()
        fetchPopularMovies()
        
    }


    public func fetchPlayingNowMovies() {
        DDLogInfo("Start fetching PlayingNow Movies")
        let playingNowQueue = OperationQueue()
        playingNowQueue.addOperation {
            MovieListService.shared.getPlayingNowMovieList(complition: self.playingNowResultHandler)
        }
    }
    
    private func playingNowResultHandler(result: Result<[PlayingNow], ActionError>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let posterList):
                DDLogInfo("PlayingNow Movies count: \(posterList.count)")
                
                DDLogInfo("PlayingNow Movie List updated")
            case .failure(let error):
                DDLogError("Fetch PlayingNow MovieList errror: \(error)")
            }
        }
    }
    
    public func fetchPopularMovies() {
        DDLogInfo("Start fetching Popular Movies")
        
        let popularQueue = OperationQueue()
        popularQueue.addOperation {
            MovieListService.shared.getPopularMovieList(for: 1, complition: self.popularMovieDetailsResultHandler)
        }
    }
    
    private func popularMovieDetailsResultHandler(result: Result<PopularDetailsList, ActionError>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let movieList):
                DDLogInfo("Popular Movies count: \(movieList.results.count)")
               
                DDLogInfo("Popular Movie List updated")
            case .failure(let error):
                DDLogError("Fetch Popular MovieList errror: \(error)")
            }
        }
    }
}

