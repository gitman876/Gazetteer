//
//  CountryWeatherForecastCellView.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 20/05/2023.
//

import SwiftUI

struct CountryWeatherForecastCellView: View {
    
    let list: List
    
    typealias Utility = FormatterHelper
    
    var body: some View {
        HStack {
            Spacer()
            Text(Utility.formattedDateString(list.dt))
                .padding()
            Divider()
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(list.weather[0].icon)@2x.png")) { image in
                image
                    .resizable()
                    .frame(width: 50, height: 50)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            Divider()
            Text("\((Utility.formattedNumberString(Int(list.main.temp)))) °C")
            Divider()
            Text(list.weather[0].desc)
            Spacer()
        }
    }
}

