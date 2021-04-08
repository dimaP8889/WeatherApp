//
//  WeatherMainViewModel.swift
//  WeatherApp
//
//  Created by Dmytro Pogrebniak on 07.04.2021.
//

import Foundation

final class WeatherMainViewModel : ObservableObject {
    
    @Published var isAnimationNeeded : Bool = true
    
    var listViewModel = CityListViewModel()
}
