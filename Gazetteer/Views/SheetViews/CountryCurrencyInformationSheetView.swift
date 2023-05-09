//
//  CountryCurrencyInformationSheetView.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 20/05/2023.
//

import SwiftUI

struct CountryCurrencyInformationSheetView: View {
    
    let country: Country
    @StateObject var viewModel: CountryCurrencyInformationSheetViewModel
    
    typealias Utility = FormatterHelper
    
    var body: some View {
        ScrollView {
            switch viewModel.state {
                case .loading:
                    self.showLoadingView()
                case .loaded(let rate):
                    self.showCurrencyExchangeView(rate: rate)
                case .error(_):
                    self.showErrorView()
            }
        }
        .onAppear {
            viewModel.fetchCountryCurrencyInformation()
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
    func showCurrencyExchangeView(rate: Double) -> some View {
        VStack {
            MainSheetHeaderView(country: country, description: "Currency and Exchange rate of")
            
            CountryInfoCellView(title: "Currency Name", detail: country.currencyName)
                .background(Color.darkPurple)
            CountryInfoCellView(title: "Currency Name", detail: country.currencyCode)
                .background(Color.lightGreen)
            CountryInfoCellView(title: "Currency symbol", detail: country.currencySymbol)
                .background(Color.darkPurple)
            CountryInfoCellView(title: "Currency exchange rate", detail: "1 $ is \(String(format: "%.2f", rate)) \(country.currencyCode)")
                .background(Color.lightGreen)
        }
    }
    
    @ViewBuilder
    func showErrorView() -> some View {
        VStack {
            padding()
            Text("Error")
            padding()
        }
    }
    
}

struct CountryCurrencyInformationSheetView_Previews: PreviewProvider {
    
    static var country = Country(name: Name(common: "China", nativeName: nil), cca2: "", currencies: ["GBP" : Currency(name: "", symbol: "£")], capital:["London"], region: "", languages: nil, latlng: nil, area: 100001010, population: 101099393, timezones: [], flags: Flags(png: "https://flagcdn.com/w320/mm.png", svg: "", alt: ""))
    
    static var previews: some View {
        CountryCurrencyInformationSheetView(
            country: country,
            viewModel: CountryCurrencyInformationSheetViewModel(
            country: country))
    }
}
