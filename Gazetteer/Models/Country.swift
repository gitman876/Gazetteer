//
//  Country.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 02/05/2023.
//

import Foundation

struct Country: Codable, Hashable {
    let name: Name
    let cca2: String
    let latlng: [Double]?
}

struct Name: Codable, Hashable {
    let common: String
}



