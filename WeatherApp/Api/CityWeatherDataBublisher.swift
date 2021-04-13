//
//  CityWeatherApi.swift
//  WeatherApp
//
//  Created by Dmytro Pogrebniak on 13.04.2021.
//

import Foundation
import Combine

final class CityWeatherDataBublisher {
    
    private func url(lat: String, lon: String) -> URL {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/onecall"
        components.queryItems = [
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "lon", value: lon),
            URLQueryItem(name: "exclude", value: "hourly,minutely,alerts"),
            URLQueryItem(name: "appid", value: "aa27dbc922b914a51b1fca5b9e6c6927"),
            URLQueryItem(name: "units", value: "metric")
        ]
        return components.url!
    }
}

extension CityWeatherDataBublisher {
    
    public func publisher(lat: String, lon: String) -> AnyPublisher<Data, URLError> {
        
        URLSession.shared.dataTaskPublisher(for: url(lat: lat, lon: lon))
            .map(\.data)
            .eraseToAnyPublisher()
    }
}
