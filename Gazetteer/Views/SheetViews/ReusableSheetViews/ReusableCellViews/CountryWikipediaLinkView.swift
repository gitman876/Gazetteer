//
//  CountryWikipediaLinkView.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 19/05/2023.
//

import SwiftUI

struct CountryWikipediaLinkView: View {
    let title: String
    let countryName: String
    
    var wikipediaURL: URL? {
        let formattedCountryName = countryName.replacingOccurrences(of: " ", with: "_")
        return URL(string: "https://en.wikipedia.org/wiki/\(formattedCountryName)")
    }
    
    var body: some View {
        HStack {
            Spacer()
            Text("\(title): ")
                .padding()
            
            if let url = wikipediaURL {
                Link("Click here", destination: url)
            } else {
                Text("Unavailable")
            }
            
            Spacer()
        }
    }
}

