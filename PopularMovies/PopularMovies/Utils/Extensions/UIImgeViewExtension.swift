//
//  UIImgeViewExtension.swift
//  PopularMovies
//
//  Created by Vivatum on 07/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import Foundation
import CocoaLumberjackSwift

extension UIImageView {
    
    func setupImageByPath(_ path: String?) {
        
        guard let pathString = path else {
            self.setPosterPlaceholder()
            return
        }
        
        guard let url = URLFactory.posterRequestURL(pathString) else {
            DDLogError("Can't get poster URL")
            self.setPosterPlaceholder()
            return
        }
        
        ImageLoadingService.shared.getImageData(url) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            case .failure(let error):
                self.setPosterPlaceholder()
                DDLogError("Can't get image data: \(error.localizedDescription)")
            }
        }
    }
    
    private func setPosterPlaceholder() {
        DispatchQueue.main.async {
            if let placeholderImage = UIImage(named: "posterPlaceholder") {
                self.image = placeholderImage
            }
        }
    }
}
