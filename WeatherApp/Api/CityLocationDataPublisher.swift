//
//  CityLocationDataPublisher.swift
//  WeatherApp
//
//  Created by Dmytro Pogrebniak on 13.04.2021.
//

import Foundation
import Combine

final class CityLocationDataPublisher {
    
    private func url(for city: String, and country: String) -> URL {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "maps.googleapis.com"
        components.path = "/maps/api/geocode/json"
        components.queryItems = [
            URLQueryItem(name: "address", value: "\(city)+\(country)"),
            URLQueryItem(name: "key", value: "AIzaSyBSa_EiwiT2ihx9c4ETrbyJH3Tb90LJOMo")
        ]
        return components.url!
    }
}

extension CityLocationDataPublisher {
    
    public func publisher(for city: String, and country: String) -> AnyPublisher<Data, URLError> {
        
        URLSession.shared.dataTaskPublisher(for: url(for: city, and: country))
            .map(\.data)
            .eraseToAnyPublisher()
    }
}
