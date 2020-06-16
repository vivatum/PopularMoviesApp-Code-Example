//
//  MovieListDataSource.swift
//  PopularMovies
//
//  Created by Vivatum on 07/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import UIKit

public struct CellIdentifiers {
    static let playingNow = "PlayingNowCell"
    static let popular = "PopularCell"
}

final class MovieListDataSource: NSObject, UITableViewDataSource {
    
    public var playingNowCollection: [PlayingNow] = []
    public var popularCollection: [MovieDetails] = []
    
    private let cellIdFormat = "movie_%d_%d"
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return popularCollection.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.playingNow, for: indexPath) as? PlayingNowTableViewCell else { return UITableViewCell() }
            cell.posterCollection = self.playingNowCollection
            cell.isAccessibilityElement = true
            cell.accessibilityIdentifier = String(format: cellIdFormat, indexPath.section, indexPath.row)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.popular, for: indexPath) as? PopularTableViewCell else { return UITableViewCell() }
            cell.details = self.popularCollection[indexPath.row]
            cell.isAccessibilityElement = true
            cell.accessibilityIdentifier = String(format: cellIdFormat, indexPath.section, indexPath.row)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "header.playing.now".localized
        case 1:
            return "header.popular".localized
        default:
            return nil
        }
    }
}
