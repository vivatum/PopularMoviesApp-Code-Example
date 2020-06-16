//
//  GenresTextBuilder.swift
//  PopularMovies
//
//  Created by Vivatum on 12/06/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import UIKit

protocol GenresTextBuilderProtocol: class {
    func getAttributedTextView(with genres: [String],
                               completion: @escaping (Result<NSMutableAttributedString, BuilderError>) -> Void)
    var labelFactory: GenreLabelFactoryProtocol? { get set }
    var imagesFactory: GenreImagesFactoryProtocol? { get set }
    var attrTextFactory: AttributedTextFactoryProtocol? { get set }
}

enum BuilderError: Error {
    case labelError
    case imagesError
    case attrTextError
}

final class GenresTextBuilder: GenresTextBuilderProtocol {
    
    var labelFactory: GenreLabelFactoryProtocol?
    var imagesFactory: GenreImagesFactoryProtocol?
    var attrTextFactory: AttributedTextFactoryProtocol?
    
    init(
        labelFactory: GenreLabelFactoryProtocol = GenreLabelFactory(),
        imagesFactory: GenreImagesFactoryProtocol = GenreImagesFactory(),
        attrTextFactory: AttributedTextFactoryProtocol = AttributedTextFactory()
    ) {
        self.labelFactory = labelFactory
        self.imagesFactory = imagesFactory
        self.attrTextFactory = attrTextFactory
    }
    
    func getAttributedTextView(with genres: [String], completion: @escaping (Result<NSMutableAttributedString, BuilderError>) -> Void) {
        
        let params = GenreTextParameters(
            words: genres,
            space: " ",
            offsetWidth: 20.0,
            offsetHeight: 10.0,
            cornerRadius: 6.0,
            backgroundColor: AppColor.genreBackground,
            textColor: AppColor.genreText,
            font: AppFont.genre ?? UIFont.systemFont(ofSize: 11))
        
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
