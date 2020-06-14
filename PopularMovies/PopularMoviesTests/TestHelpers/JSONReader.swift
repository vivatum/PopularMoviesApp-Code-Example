//
//  JSONReader.swift
//  PopularMovies
//
//  Created by Vivatum on 09/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import Foundation
import CocoaLumberjackSwift

public final class JSONReader {
    
    public static func readJSON(forResource fileName: String) -> Data? {
        
        let bundle = Bundle(for: JSONReader.self)
        guard let path = bundle.path(forResource: fileName, ofType: "json") else {
            DDLogError("Can't get JSON path")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return data
        } catch (let error){
            DDLogError("Can't read JSON data: \(error.localizedDescription)")
            return nil
        }
    }
}
