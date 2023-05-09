//
//  Country.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 02/05/2023.
//

import Foundation

// MARK: -
// MARK: Decodable

struct Country: Decodable, Hashable {
    let name: Name
    let cca2: String
    let currencies: [String : Currency]?
    let capital: [String]?
    let region: String
    let languages: [String : String]?
    let latlng: [Double]?
    let area: Double
    let population: Int
    let timezones: [String]
    let flags: Flags
}

struct Name: Decodable, Hashable {
    let common: String
    let nativeName: [String : Translation]?
}

struct Currency: Decodable, Hashable {
    let name: String
    let symbol: String?
}

struct Translation: Decodable, Hashable {
    let official, common: String
}

struct Flags: Decodable, Hashable {
    let png: String
    let svg: String
    let alt: String?
}

// MARK: -
// MARK: extension Country, computed properties

extension Country {
    
    var currencyName: String {
        if let currencies = self.currencies {
            for (_, currency) in currencies {
                return currency.name
            }
        }
        return "Currency name unavailable"
    }
    
    var currencyCode: String {
        if let currencies = self.currencies {
            for (currencyCode, _ ) in currencies {
                return currencyCode
            }
        }
        return "Currency code unavailable"
    }
    
    var currencySymbol: String {
        if let currencies = self.currencies {
            for (_, currency) in currencies {
                return currency.symbol ?? "Currency name unavailable"
            }
        }
        return "Currency symbol unavailable"
    }
    
    var latitude: Double {
        return self.latlng?[0] ?? 0
    }
    
    var longitude: Double {
        return self.latlng?[1] ?? 0
    }
    
    var countryNativeName: String {
        if let nativeNames = self.name.nativeName {
            for (_, translation) in nativeNames {
                let nativeName = translation.common
                return nativeName
            }
        }
        return "Native name not available"
    }
    
    var countryLanguage: String {
        if let languages = self.languages {
            return languages.values.joined(separator: ", ")
        }
        return "Language not available"
    }

}
