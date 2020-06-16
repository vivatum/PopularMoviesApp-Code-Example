//
//  GenresTextBuilder.swift
//  WordsAsTagLabels
//
//  Created by Volodymyr Vozniak on 12/06/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import UIKit

protocol TextViewBuilderProtocol: class {
    func getAttributedTextView(with params: TextViewParameters, completion: @escaping (Result<NSMutableAttributedString, BuilderError>) -> Void)
    var labelFactory: LabelFactoryProtocol? { get set }
    var imagesFactory: ImagesFactoryProtocol? { get set }
    var attrTextFactory: AttributedTextFactoryProtocol? { get set }
}

enum BuilderError: Error {
    case labelError
    case imagesError
    case attrTextError
}

final class GenresTextBuilder: TextViewBuilderProtocol {
    
    var labelFactory: LabelFactoryProtocol?
    var imagesFactory: ImagesFactoryProtocol?
    var attrTextFactory: AttributedTextFactoryProtocol?
    
    init(
        labelFactory: LabelFactoryProtocol = LabelFactory(),
        imagesFactory: ImagesFactoryProtocol = ImagesFactory(),
        attrTextFactory: AttributedTextFactoryProtocol = AttributedTextFactory()
    ) {
        self.labelFactory = labelFactory
        self.imagesFactory = imagesFactory
        self.attrTextFactory = attrTextFactory
    }
    
    func getAttributedTextView(with params: TextViewParameters, completion: @escaping (Result<NSMutableAttributedString, BuilderError>) -> Void) {
        guard let labels = self.labelFactory?.getLabelArray(with: params) else {
            completion(.failure(.labelError))
            return
        }
        guard let images = self.imagesFactory?.createImagesArray(labelArray: labels) else {
            completion(.failure(.imagesError))
            return
        }
        guard let attrText = self.attrTextFactory?.createAttributedTextForImages(imageArray: images, space: params.space) else {
            completion(.failure(.attrTextError))
            return
        }
        completion(.success(attrText))
    }
    
}
