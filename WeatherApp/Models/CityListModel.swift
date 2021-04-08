//
//  CityListModel.swift
//  WeatherApp
//
//  Created by Dmytro Pogrebniak on 25.03.2021.
//

import Foundation

struct CityListModel {

    let letter : Character
    var place : CityNameModel
}

struct LetterSectionModel : Hashable {
    
    let letter : Character
    var cities : [CityNameModel]
}


struct CityNameModel : Hashable {
    
    let city : String
    let country : String
}
