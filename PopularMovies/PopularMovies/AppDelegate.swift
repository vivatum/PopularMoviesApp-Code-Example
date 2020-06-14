//
//  AppDelegate.swift
//  PopularMovies
//
//  Created by Volodymyr Vozniak on 14/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import UIKit
import CocoaLumberjackSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var fileLogger: DDFileLogger!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureCocoaLumberjackSwift()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


    // MARK: - CocoaLumberjackSwift config
    
    private final func configureCocoaLumberjackSwift() {
        
        setenv("XcodeColors", "YES", 0)
        
        let ddttyLogger = DDOSLogger.sharedInstance
        ddttyLogger.logFormatter = LogFormatter()
        DDLog.add(ddttyLogger)
        
        self.fileLogger = DDFileLogger()
        
        self.fileLogger.rollingFrequency = TimeInterval(60 * 60 * 24)
        self.fileLogger.maximumFileSize = 512 * 512
        self.fileLogger.logFileManager.maximumNumberOfLogFiles = 3
        self.fileLogger.logFormatter = LogFormatter()
        
        DDLogInfo("Log framework configured successfully.")
    }
}

