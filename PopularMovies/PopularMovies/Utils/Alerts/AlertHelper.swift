//
//  AlertHelper.swift
//  PopularMovies
//
//  Created by Vivatum on 05/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import UIKit
import CocoaLumberjackSwift

public struct AlertHelper {
    
    static func showErrorAlert(_ alert: AlertMessage, action: (() -> Void)? = nil) {
        
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "allert.button.ok".localized, style: .cancel, handler: { alertAction -> Void in
            action?()
        }))
        
        guard let topViewController = UIApplication.topViewController() else {
            DDLogError("Can't get topViewController")
            return
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = topViewController.view
        }
        
        DispatchQueue.main.async {
            topViewController.present(alertController, animated: true, completion: nil)
        }
    }
    
}

