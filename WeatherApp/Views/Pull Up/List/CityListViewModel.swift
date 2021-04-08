//
//  CityListModel.swift
//  WeatherApp
//
//  Created by Dmytro Pogrebniak on 25.03.2021.
//

import Combine
import SwiftUI

final class CityListViewModel : ObservableObject {
    
    private var places : [CityListModel] = [] {
        didSet { createSectionModel() }
    }
    
    @Published var cities : [LetterSectionModel] = []
    
    @Published var filter : String = "" {
        didSet {
            places = []
            fileManager.getData()
        }
    }
    
    private let fileManager = CitiesFileManager()
    private var publisher : AnyPublisher<CityListModel, Never>
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        publisher = fileManager.getPublisher()
        publisher
            .filter {(model) -> Bool in
                if self.filter.isEmpty { return true }
                return (model.place.city.contains(self.filter)
                            || model.place.country.contains(self.filter))
            }
            .sink { (data) in
                self.places.append(data)
            }
            .store(in: &subscriptions)
        
        
        fileManager.getData()
    }
}

// MARK: - Privat
private extension CityListViewModel {
    
    func createSectionModel() {
        
        var sections = [LetterSectionModel]()
        places.forEach { (model) in
            
            guard var data = sections.first(where: { $0.letter == model.letter }) else {
                sections.append(LetterSectionModel(letter: model.letter, cities: [model.place]))
                return
            }
            
            data.cities.append(model.place)
            
            sections.removeAll(where: { $0.letter == data.letter })
            sections.append(data)
        }
        cities = sections
    }
}
