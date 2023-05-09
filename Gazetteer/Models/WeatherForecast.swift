//
//  WeatherForecast.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 19/05/2023.
//

import Foundation

struct WeatherForecast: Decodable {
    let list: [List]
}

struct MainClass: Decodable {
    let temp: Double
}

struct List: Decodable {
    let dt: Int
    let main: MainClass
    let weather: [WeatherInfo]
}

struct WeatherInfo: Decodable {
    let desc: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case desc = "description"
        case icon
    }
}
