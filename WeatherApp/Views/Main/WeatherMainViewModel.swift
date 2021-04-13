//
//  WeatherMainViewModel.swift
//  WeatherApp
//
//  Created by Dmytro Pogrebniak on 07.04.2021.
//

import Foundation
import Combine

final class WeatherMainViewModel : ObservableObject {
    
    @Published var isAnimationNeeded : Bool = true
    var listViewModel = CityListViewModel()
    
    private var cityWeatherService = CityWeatherDataBublisher()
    private var cityLocationService = CityLocationDataPublisher()
    private var subscriptions = Set<AnyCancellable>()
    
    func search(city : String, country: String) {
        
        cityLocationService.publisher(for: city, and: country)
            .retry(2)
            .decode(type: LocationModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .replaceError(with: LocationModel())
            .handleEvents(receiveOutput: {
                print($0)
            })
            .flatMap { [unowned self] (model) in

                self.cityWeatherService.publisher(lat: model.lat, lon: model.lon)
            }
            .handleEvents(receiveOutput: {
                print(String(data: $0, encoding: .utf8))
            })
    }
}
