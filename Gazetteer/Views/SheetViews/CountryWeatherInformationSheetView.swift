//
//  CountryWeatherInformationSheetView.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 19/05/2023.
//

import SwiftUI

struct CountryWeatherInformationSheetView: View {
    
    let country: Country
    @StateObject var viewModel: CountryWeatherInformationSheetViewModel
    
    typealias Utility = FormatterHelper
    
    var body: some View {
        ScrollView {
            switch viewModel.state {
                case .loading:
                    self.showLoadingView()
                case .loaded(let weatherData):
                    self.showCountryWeatherInformationView(countryWeatherInfo: weatherData)
                case .error(_):
                    self.showErrorView()
            }
        }
        .onAppear {
            viewModel.fetchCountryWeather()
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
    func showCountryWeatherInformationView(countryWeatherInfo info: Weather) -> some View {
        VStack {
            MainSheetHeaderView(country: country, description: "Current weather in")
            
            Group {
                CountryWeatherIconInformationCellView(weatherInfo: info)
                    .background(Color.lightGreen)
                CountryInfoCellView(title: "Feels like", detail: "\(info.main.feelsLike) °C")
                    .background(Color.darkPurple)
                CountryInfoCellView(title: "Minimum temperature", detail: "\(info.main.tempMin) °C")
                    .background(Color.lightGreen)
                CountryInfoCellView(title: "Maximum temperature", detail: "\(info.main.tempMax) °C")
                    .background(Color.darkPurple)
                CountryInfoCellView(title: "Pressure", detail: "\(info.main.pressure) Hg")
                    .background(Color.lightGreen)
                CountryInfoCellView(title: "Humidity", detail: "\(info.main.humidity) %")
                    .background(Color.darkPurple)
            }
            
            Group {
                CountryInfoCellView(title: "Clouds", detail: "\(info.clouds.all) %")
                    .background(Color.lightGreen)
                CountryInfoCellView(title: "Windspeed", detail: "\(info.wind.speed) mph")
                    .background(Color.darkPurple)
                CountryInfoCellView(title: "Wind Direction", detail: "\(info.wind.deg) °")
                    .background(Color.lightGreen)
                CountryInfoCellView(title: "Windspeed", detail: "\(info.wind.speed) mph")
                    .background(Color.darkPurple)
                CountryInfoCellView(title: "Sunrise", detail: Utility.formattedTimeString(info.sys.sunrise))
                    .background(Color.lightGreen)
                CountryInfoCellView(title: "Sunset", detail: Utility.formattedTimeString(info.sys.sunset))
                    .background(Color.darkPurple)
            }
            
            Spacer()
        }

    }
    
    @ViewBuilder
    func showErrorView() -> some View {
        VStack {
            Text("Error")
        }
    }
    
}

struct CountryWeatherInformationSheetView_Previews: PreviewProvider {
    
    static var country = Country(name: Name(common: "Myanmar", nativeName: nil), cca2: "", currencies: ["GBP" : Currency(name: "", symbol: "£")], capital: nil, region: "", languages: nil, latlng: nil, area: 10000, population: 10200303, timezones: [], flags: Flags(png: "https://flagcdn.com/w320/mm.png", svg: "", alt: ""))
    
    static var previews: some View {
        CountryWeatherInformationSheetView(
            country: country,
            viewModel: CountryWeatherInformationSheetViewModel(
                country: country))
    }
}
