//
//  String+Extension.swift
//  WeatherApp
//
//  Created by Dmytro Pogrebniak on 30.03.2021.
//

import Foundation

extension String {
    
    var isAlphabet : Bool {
        
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z].*", options: [])
            if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
                return false
            } else {
                return true
            }
        }
        catch {
            return false
        }
    }
}
