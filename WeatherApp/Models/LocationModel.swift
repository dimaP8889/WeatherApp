//
//  LocationModel.swift
//  WeatherApp
//
//  Created by Dmytro Pogrebniak on 13.04.2021.
//

import Foundation

struct LocationModel : Decodable {
    
    let lat : String
    let lon : String
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        guard let result = try container.decode([Results].self, forKey: .results).first else {
            lat = ""
            lon = ""
            return
        }
        
        lat = "\(result.geometry.location.lat)"
        lon = "\(result.geometry.location.lng)"
    }
    
    init() {
        lat = ""
        lon = ""
    }
}

private extension LocationModel {
    
    struct Results : Decodable {
        let geometry : Geometry
    }
    
    struct Geometry : Decodable {
        let location : Location
    }
    
    struct Location : Decodable {
        let lat : Double
        let lng : Double
    }
    
    enum CodingKeys : String, CodingKey {
        case results
    }
}
