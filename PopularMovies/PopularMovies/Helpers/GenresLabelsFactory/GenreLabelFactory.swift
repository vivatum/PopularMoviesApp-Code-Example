//
//  GenreLabelFactory.swift
//  WordsAsTagLabels
//
//  Created by Volodymyr Vozniak on 12/06/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import UIKit

protocol GenreLabelFactoryProtocol: class {
    func getLabelArray(with params: GenreTextParameters) -> [UILabel]
    func createLabel(with params: GenreLabelParameters) -> UILabel
}

final class GenreLabelFactory: GenreLabelFactoryProtocol {
    
    func getLabelArray(with params: GenreTextParameters) -> [UILabel] {
        var labels = [UILabel]()
        for (_, word) in params.words.enumerated() {
            
            let labParams = GenreLabelParameters(
                word: word,
                offsetWidth: params.offsetWidth,
                offsetHeight: params.offsetHeight,
                cornerRadius: params.cornerRadius,
                backgroundColor: params.backgroundColor,
                textColor: params.textColor,
                font: params.font)
            
            let label = createLabel(with: labParams)
            labels.append(label)
        }
        return labels
    }
    
    func createLabel(with params: GenreLabelParameters) -> UILabel {
        let label = UILabel()
        label.text = params.word.uppercased()
        label.textColor = params.textColor
        label.font = params.font
        label.textAlignment = .center
        label.backgroundColor = params.backgroundColor
        label.sizeToFit()
        
        let frame = label.frame
        let newWidth = frame.width + params.offsetWidth
        let newHeight = frame.height + params.offsetHeight
        
        label.frame = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
        label.clipsToBounds = true
        label.layer.cornerRadius = params.cornerRadius
        
        return label
    }
}
