//
//  UIApplicationExtension.swift
//  PopularMovies
//
//  Created by Vivatum on 05/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import UIKit

extension UIApplication {
    
    class final func topViewController(_ base: UIViewController? = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        
        return base
    }
}
