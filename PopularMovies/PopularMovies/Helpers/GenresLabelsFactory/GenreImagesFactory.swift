//
//  GenreImagesFactory.swift
//  PopularMovies
//
//  Created by Vivatum on 12/06/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import UIKit

protocol GenreImagesFactoryProtocol: class {
    func createImagesArray(labelArray: [UILabel]) -> [UIImage]?
    func getImageFromLabel(_ label: UILabel) -> UIImage?
}

final class GenreImagesFactory: GenreImagesFactoryProtocol {
    
    func createImagesArray(labelArray: [UILabel]) -> [UIImage]? {
        guard !labelArray.isEmpty else { return nil }
        var images = [UIImage]()
        for (_, label) in labelArray.enumerated() {
            if let image = getImageFromLabel(label) {
                images.append(image)
            }
        }
        return images
    }
    
    func getImageFromLabel(_ label: UILabel) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(label.frame.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { exit(0) }
        label.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
