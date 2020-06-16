//
//  PlayingNowTableViewCell.swift
//  PopularMovies
//
//  Created by Vivatum on 07/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import UIKit

final class PlayingNowTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    private let collectionDataSource = PlayingNowDataSource()
    private var noDataView: NoDataView?
    
    var posterCollection: [PlayingNow] = [] {
        didSet {
            noDataView?.message = posterCollection.isEmpty ? .noDataFetched : .noMessage
            collectionDataSource.data = posterCollection
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        noDataView = NoDataView(frame: self.bounds)
        noDataView?.message = .loading
        
        collectionView.backgroundView = noDataView
        collectionView.dataSource = self.collectionDataSource
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
    }
}

extension PlayingNowTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 106, height: 160)
    }
}
