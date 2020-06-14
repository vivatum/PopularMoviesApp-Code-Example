//
//  ImageLoadingService.swift
//  PopularMovies
//
//  Created by Vivatum on 07/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import Foundation
import CocoaLumberjackSwift

final class ImageLoadingService {
    
    static let shared = ImageLoadingService()
    private init(){}
    
    private lazy var imageCache: NSCache<NSString, NSData> = {
        let cache = NSCache<NSString, NSData>()
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    func getImageData(_ url: URL, closure: @escaping ((Result<Data, ActionError>) -> Void)) {
        
        if let cacheImageData = imageCache.object(forKey: url.absoluteString as NSString) as Data? {
            closure(.success(cacheImageData))
            return
        }
        
        guard let reachability = Reachability(), reachability.isReachable else {
            let errorMessage = "Can't load Data: Network unreachable!"
            DDLogError(errorMessage)
            return closure(.failure(.reachability(errorMessage)))
        }
        
        RequestService().loadData(url: url) { result in
            switch result {
            case .success(let imageData):
                self.imageCache.setObject(imageData as NSData, forKey: url.absoluteString as NSString)
                closure(.success(imageData))
            case .failure(let error):
                closure(.failure(.custom("Can't download image data: \(error.localizedDescription)")))
            }
        }
    }
}
