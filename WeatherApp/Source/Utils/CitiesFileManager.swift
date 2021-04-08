//
//  FileManager.swift
//  WeatherApp
//
//  Created by Dmytro Pogrebniak on 25.03.2021.
//

import Foundation
import Combine

final class CitiesFileManager {
    
    private let parser = FileParser()
    private let reader = FileReader(name: "cities.txt")
    private var data : [CityListModel]? = nil
    
    private var publisher : PassthroughSubject<CityListModel, Never>
    
    init() {
        publisher = PassthroughSubject<CityListModel, Never>()

    }
    
    func getPublisher() -> AnyPublisher<CityListModel, Never> {
        publisher.eraseToAnyPublisher()
    }
    
    func getData() {
        
        if let saved = data {
            send(saved)
            return
        }
        
        guard let readed = reader.read() else { return }
        let data = parser.parse(file: readed)
        self.data = data
        send(data)
    }
}

// MARK: - Private
private extension CitiesFileManager {
    
    func send(_ data : [CityListModel]) {
        data.forEach {
            publisher.send($0)
        }
    }
}
