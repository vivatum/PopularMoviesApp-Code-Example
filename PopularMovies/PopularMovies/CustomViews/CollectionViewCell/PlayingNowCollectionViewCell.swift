//
//  PlayingNowCollectionViewCell.swift
//  PopularMovies
//
//  Created by Vivatum on 07/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import UIKit

final class PlayingNowCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    var poster: PlayingNow? {
        didSet {
            self.posterImageView.setupImageByPath(self.poster?.posterPath)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
