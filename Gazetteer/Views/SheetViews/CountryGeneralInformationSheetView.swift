//
//  CountryGeneralInformationSheetView.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 19/05/2023.
//

import SwiftUI

struct CountryGeneralInformationSheetView: View {
    
    let country: Country
    
    typealias Utility = FormatterHelper
    
    var body: some View {
        ScrollView {
            VStack {
                MainSheetHeaderView(country: country, description: "General information about")
                
                Group {
                    CountryInfoCellView(title: "Name", detail: country.name.common)
                        .background(Color.darkPurple)
                    CountryInfoCellView(title: "Capital", detail: country.capital?[0] ?? "Unavailable")
                        .background(Color.lightGreen)
                    CountryInfoCellView(title: "Region", detail: country.region)
                        .background(Color.darkPurple)
                    CountryInfoCellView(title: "Population", detail: Utility.formattedNumberString(country.population))
                        .background(Color.lightGreen)
                    CountryInfoCellView(title: "Timezone", detail: country.timezones[0])
                        .background(Color.darkPurple)
                }
                
                Group {
                    CountryInfoCellView(title: "Country area", detail: "\(Utility.formattedNumberString(Int(country.area))) km²")
                        .background(Color.lightGreen)
                    CountryInfoCellView(title: "Native Name", detail: country.countryNativeName)
                        .background(Color.darkPurple)
                    CountryFlagCellView(title: "Flag", flagUrlString: country.flags.png)
                        .background(Color.lightGreen)
                    CountryInfoCellView(title: "Language", detail: country.countryLanguage)
                        .background(Color.darkPurple)
                    CountryWikipediaLinkView(title: "Wikipedia", countryName: country.name.common)
                        .background(Color.lightGreen)
                }
                
                Spacer()
            }
        }
        .background(Color.cyan)
    }
}

struct CountryGeneralInformationSheetView_Previews: PreviewProvider {
    static var previews: some View {
        CountryGeneralInformationSheetView(country: Country(name: Name(common: "Myanmar", nativeName: nil), cca2: "BR", currencies: ["GBP" : Currency(name: "", symbol: "£")], capital: nil, region: "Asia", languages: ["nil":""], latlng: nil, area: 100, population: 10000000, timezones: ["UTC-08:00"], flags: Flags(png: "https://flagcdn.com/w320/mm.png", svg: "", alt: "")))
    }
}
