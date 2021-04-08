//
//  FileReader.swift
//  WeatherApp
//
//  Created by Dmytro Pogrebniak on 25.03.2021.
//

import Foundation

final class FileReader {
    
    private let name : String
    
    init(name : String) {
        self.name = name
    }
}

// MARK: - Public
extension FileReader {
    
    func read() -> String? {
        
        let path = Bundle.main.path(forResource: "cities", ofType: "txt") // file path for file "data.txt"
        let string = try? String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        return string
    }
}
