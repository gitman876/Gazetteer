//
//  Currency.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 20/05/2023.
//

import Foundation

struct CurrencyExchangeRates: Decodable {
    let rates: [String : Double]
}
