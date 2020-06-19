//
//  GenresLabelsFactory.swift
//  PopularMovies
//
//  Created by Vivatum on 08/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import UIKit

final class GenresLabelsFactory {
    
    private let wordsArray: [String]
    
    init(wordsArray: [String]) {
        self.wordsArray = wordsArray
    }
    
    public func getGenresAttributedText() -> NSMutableAttributedString? {
        guard let images = createImagesArray(for: wordsArray) else {
            return nil
        }
        return getAttributedText(with: images)
    }
    
    private func getAttributedText(with images: [UIImage]) -> NSMutableAttributedString {
        let space = " "
        let attrText = NSMutableAttributedString()
        let attrSpace = NSAttributedString(string: space)
        
        for image in images {
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = image
            imageAttachment.bounds = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
            let imageString = NSAttributedString(attachment: imageAttachment)
            attrText.append(imageString)
            attrText.append(attrSpace)
        }
        return attrText
    }

    private func createImagesArray(for words: [String]) -> [UIImage]? {
        
        guard !words.isEmpty else { return nil }
        
        var images = [UIImage]()
        for (_, string) in words.enumerated() {
            let label = createSingleLabel(with: string)
            if let image = getImageFromLabel(label) {
                images.append(image)
            }
        }
        return images
    }
    
    private func createSingleLabel(with text: String) -> UILabel {

        let label = UILabel()
        label.text = text.uppercased()
        label.textColor = AppColor.genreText
        label.font = AppFont.genre
        label.textAlignment = .center
        label.backgroundColor = AppColor.genreBackground
        label.sizeToFit()
        
        let frame = label.frame
        let offsetWidth: CGFloat = 20.0
        let offsetHeight: CGFloat = 10.0
        let newWidth = frame.width + offsetWidth
        let newHeight = frame.height + offsetHeight
        
        label.frame = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
        label.clipsToBounds = true
        label.layer.cornerRadius = 6.0
        
        return label
    }
    
    private func getImageFromLabel(_ label: UILabel) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(label.frame.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { exit(0) }
        label.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
