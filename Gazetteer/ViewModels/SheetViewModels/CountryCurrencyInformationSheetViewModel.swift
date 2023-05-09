//
//  File.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 20/05/2023.
//

import Foundation

final class CountryCurrencyInformationSheetViewModel: ObservableObject {
    enum CountryCurrencyInformationState {
        case loading
        case loaded(Double)
        case error(Error)
    }
    
    @Published private(set) var state: CountryCurrencyInformationState = .loading
    
    let country: Country
    
    init(country: Country) {
        self.country = country
    }
    
    func fetchCountryCurrencyInformation() {
        guard let url = URL(string: "https://openexchangerates.org/api/latest.json?app_id=ded41ba1ffcd48e98af50cf41d9003d8") else {
            self.state = .error(NetworkError.invalidURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                self.state = .error(NetworkError.noData)
                return
            }
            do {
                let countryExchangeRates = try JSONDecoder().decode(CurrencyExchangeRates.self, from: data)
                let filteredExchangeRate = countryExchangeRates.rates.filter { rate in
                    return rate.key == self.country.currencyCode
                }
                DispatchQueue.main.async {
                    self.state = .loaded(filteredExchangeRate.values.first ?? 0)
                }
            } catch {
                DispatchQueue.main.async {
                    self.state = .error(NetworkError.noData)
                }
            }
        }.resume()
    }
    
}
