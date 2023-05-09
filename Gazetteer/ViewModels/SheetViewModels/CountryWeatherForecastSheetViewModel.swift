//
//  CountryWeatherForecastSheetViewModel.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 19/05/2023.
//

import Foundation

final class CountryWeatherForecastSheetViewModel: ObservableObject {
    
    enum CountryWeatherForecastState {
        case loading
        case loaded(WeatherForecast)
        case error(Error)
    }
    
    @Published private(set) var state: CountryWeatherForecastState = .loading
    
    let country: Country
    
    init(country: Country) {
        self.country = country
    }
    
    func fetchWeatherForecast() {
        guard let countryCapital = country.capital?[0] else {
            self.state = .error(NetworkError.invalidURL)
            return
        }
        let countryCapitalFormatted = countryCapital.replacingOccurrences(of: " ", with: "")
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(countryCapitalFormatted)&appid=97108b1ae73ccc66f7d6f68139130bb2&units=metric") else {
            self.state = .error(NetworkError.invalidURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    self.state = .error(NetworkError.noData)
                }
                return
            }
            
            do {
                let weatherForecastData = try JSONDecoder().decode(WeatherForecast.self, from: data)
                DispatchQueue.main.async {
                    self.state = .loaded(weatherForecastData)
                }
            } catch {
                DispatchQueue.main.async {
                    self.state = .error(error)
                }
            }
        }.resume()
    }
    
    
}
