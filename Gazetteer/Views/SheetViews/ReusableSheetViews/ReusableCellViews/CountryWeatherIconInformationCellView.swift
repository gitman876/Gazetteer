//
//  CountryWeatherIconInformationCellView.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 19/05/2023.
//

import SwiftUI

struct CountryWeatherIconInformationCellView: View {
    let weatherInfo : Weather
    
    typealias Utility = FormatterHelper
    
    var body: some View {
        HStack {
            Spacer()
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weatherInfo.weather[0].icon)@2x.png")) { image in
                image
                    .resizable()
                    .frame(width: 50, height: 50)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            VStack {
                Text(Utility.formattedNumberString(Int(weatherInfo.main.temp)))
                Text("\(weatherInfo.weather[0].desc)")
            }
            Spacer()
        }
    }
}

