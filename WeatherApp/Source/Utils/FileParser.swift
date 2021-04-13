//
//  FileParser.swift
//  WeatherApp
//
//  Created by Dmytro Pogrebniak on 25.03.2021.
//

import Foundation

final class FileParser {
    
    func parse(file : String) -> [CityListModel] {
        
        let rows = file.split(separator: "\n")
        var model = [CityListModel]()
        
        rows.forEach {
            let row = String($0)
            let words = row.split(separator: ",")
            
            guard words.count >= 2 else { return }
            
            let city = String(words[1])
            let country = String(words[0])
            appendNewCity(model: &model, city: city, country: country)
        }
        return model.sorted { $0.letter < $1.letter }
    }
}

// MARK: - Private
private extension FileParser {
    
    func appendNewCity(model : inout [CityListModel], city : String, country : String) {
        
        guard let first = city.first,
              city.isAlphabet,
              country.isAlphabet
        else { return }
        
        let cityNameModel = CityNameModel(city: city, country: country)
        let listModel = CityListModel(letter: first, place: cityNameModel)
        model.append(listModel)
    }
}
