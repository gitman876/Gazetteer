//
//  CountryWeatherInformationSheetViewModel.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 19/05/2023.
//

import Foundation

final class CountryWeatherInformationSheetViewModel: ObservableObject {
    
    enum CountryWeatherInformationState {
        case loading
        case loaded(Weather)
        case error(Error)
    }
    
    @Published private(set) var state: CountryWeatherInformationState = .loading
    
    let country: Country
    
    init(country: Country) {
        self.country = country
    }
    
    func fetchCountryWeather() {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(country.latitude)&lon=\(country.longitude)&appid=97108b1ae73ccc66f7d6f68139130bb2&units=metric") else {
            self.state = .error(NetworkError.invalidURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                self.state = .error(NetworkError.noData)
                return
            }
            
            do {
                let weatherData = try JSONDecoder().decode(Weather.self, from: data)
                DispatchQueue.main.async {
                    self.state = .loaded(weatherData)
                }
            } catch {
                self.state = .error(error)
            }
        }.resume()
    }
}
