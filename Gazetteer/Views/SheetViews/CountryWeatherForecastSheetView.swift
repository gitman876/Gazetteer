//
//  CountryWeatherForecastSheetView.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 19/05/2023.
//

import SwiftUI

struct CountryWeatherForecastSheetView: View {
    
    let country: Country
    @StateObject var viewModel: CountryWeatherForecastSheetViewModel
    
    typealias Utility = FormatterHelper
    
    var body: some View {
        ScrollView {
            switch viewModel.state {
                case .loading:
                    self.showLoadingView()
                case .loaded(let forecastInfo):
                    self.showWeatherForecastView(forecastInfo: forecastInfo)
                case .error(_):
                    self.showErrorView()
            }
        }
        .onAppear {
            viewModel.fetchWeatherForecast()
        }
        .background(Color.cyan)
    }
    
    @ViewBuilder
    func showLoadingView() -> some View {
        VStack {
            ProgressView()
        }
    }
    
    @ViewBuilder
    func showWeatherForecastView(forecastInfo info: WeatherForecast) -> some View {
        VStack {
            MainSheetHeaderView(country: country, description: "Weather forecast for the next 5 days in")
            CountryWeatherForecastCellView(list: info.list[0])
                .background(Color.lightGreen)
            CountryWeatherForecastCellView(list: info.list[1])
                .background(Color.darkPurple)
            CountryWeatherForecastCellView(list: info.list[2])
                .background(Color.lightGreen)
            CountryWeatherForecastCellView(list: info.list[3])
                .background(Color.darkPurple)
            CountryWeatherForecastCellView(list: info.list[4])
                .background(Color.lightGreen)
        }
    }
    
    @ViewBuilder
    func showErrorView() -> some View {
        VStack {
            padding()
            Text("Error")
            padding()
        }
    }
}

struct CountryWeatherForecastSheetView_Previews: PreviewProvider {
    
    static var country = Country(name: Name(common: "China", nativeName: nil), cca2: "", currencies: ["GBP" : Currency(name: "", symbol: "£")], capital:["London"], region: "", languages: nil, latlng: nil, area: 100001010, population: 101099393, timezones: [], flags: Flags(png: "https://flagcdn.com/w320/mm.png", svg: "", alt: ""))
    
    static var previews: some View {
        CountryWeatherForecastSheetView(
            country: country,
            viewModel: CountryWeatherForecastSheetViewModel(
                country: country))
    }
}
