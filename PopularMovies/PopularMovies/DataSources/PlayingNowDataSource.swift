//
//  PlayingNowDataSource.swift
//  PopularMovies
//
//  Created by Vivatum on 07/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import UIKit

final class PlayingNowDataSource: NSObject, UICollectionViewDataSource {
    
    public var data: [PlayingNow] = []
    
    private struct CellIdentifiers {
        static let cell = "PosterCell"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.cell, for: indexPath) as? PlayingNowCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.poster = data[indexPath.row]
        return cell
    }
    
}
