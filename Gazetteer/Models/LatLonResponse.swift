//
//  CountryCode.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 24/05/2023.
//

import Foundation

struct LatLonResponse: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let components: Components
}

struct Components: Decodable {
    let isoA2: String
    
    enum CodingKeys: String, CodingKey {
        case isoA2 = "ISO_3166-1_alpha-2"
    }
}
