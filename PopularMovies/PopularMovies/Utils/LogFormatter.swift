//
//  LogFormatter.swift
//  PopularMovies
//
//  Created by Volodymyr Vozniak on 14/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import Foundation
import CocoaLumberjackSwift

final class LogFormatter: NSObject, DDLogFormatter {
    
    fileprivate let threadUnsafeDateFormatter: DateFormatter
    
    override init() {
        self.threadUnsafeDateFormatter = DateFormatter()
        self.threadUnsafeDateFormatter.formatterBehavior = .behavior10_4
        self.threadUnsafeDateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss:SSS"
        super.init()
    }
    
    func format(message logMessage: DDLogMessage) -> String? {
        
        let logLevel: String
        
        switch logMessage.flag {
        case DDLogFlag.error:
            logLevel = "ERROR"
        case DDLogFlag.warning:
            logLevel = "WARNING"
        case DDLogFlag.info:
            logLevel = "INFO"
        default:
            logLevel = "MESSAGE"
        }
        
        let dateTime = self.threadUnsafeDateFormatter.string(from: logMessage.timestamp)
        
        return "\(dateTime)|\(logLevel)|\(logMessage.fileName ).\(logMessage.function ?? " ") Line:\(logMessage.line) \(logMessage.message )"
    }
}

