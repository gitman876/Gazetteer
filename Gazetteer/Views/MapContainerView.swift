//
//  ContentView.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 25/04/2023.
//

import SwiftUI
import MapKit

struct MapContainerView: View {
    
    /* `mapType` set to `.standard` initially */
    @State private var mapType: MKMapType = .standard
    
    /* Sheet presentation booleans */
    @State private var showMapTypeOptions = false
    @State private var showCountryGeneralInformation = false
    @State private var showCountryWeatherInformation = false
    @State private var showCountryWeatherForecast = false
    @State private var showCountryCurrencyInformation = false
    
    /* MapContainerViewModel dependency */
    @StateObject var viewModel: MapContainerViewModel

    var body: some View {
        VStack {
            switch viewModel.state {
                case .loading:
                    self.showLoadingView()
                case .loaded:
                    self.showMapContainerView()
                case .error:
                    self.showErrorView()
            }
        }
        .onAppear {
            viewModel.fetchCountryNames()
            viewModel.checkIfLocationServicesIsEnabled()
        }
    }
    
    @ViewBuilder
    func showLoadingView() -> some View {
        VStack {
            ProgressView()
        }
    }
    
    @ViewBuilder
    func showMapContainerView() -> some View {
        ZStack(alignment: .topTrailing) {
            
            MapUIViewRepresentable(region: viewModel.region, mapType: $mapType)
                .edgesIgnoringSafeArea(.all)

            HStack(alignment: .top) {
                VStack {
                    VStack {
                        
                        // MARK: -
                        // MARK: Zoom in-out buttons
                        
                        Button(action: {
                            let span = MKCoordinateSpan(latitudeDelta: max(viewModel.region.span.latitudeDelta / 2, 0.01), longitudeDelta: max(viewModel.region.span.longitudeDelta / 2, 0.01))
                            viewModel.region = MKCoordinateRegion(center: viewModel.region.center, span: span)
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .padding()
                        }
                        
                        Button(action: {
                            let span = MKCoordinateSpan(latitudeDelta: min(viewModel.region.span.latitudeDelta * 2, 180), longitudeDelta: min(viewModel.region.span.longitudeDelta * 2, 180))
                            viewModel.region = MKCoordinateRegion(center: viewModel.region.center, span: span)
                        }) {
                            Image(systemName: "minus")
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(8)
                    .padding()
                    
                    VStack {
                        
                        // MARK: -
                        // MARK: Country Information buttons
                        
                        /// Country `General Information` button
                        Button {
                            showCountryGeneralInformation = true
                        } label: {
                            Image(systemName: "info.square")
                                .foregroundColor(.white)
                                .padding()
                        }
                        
                        /// Country `Weather Information` button
                        Button {
                            showCountryWeatherInformation = true
                        } label: {
                            Image(systemName: "cloud.sun")
                                .foregroundColor(.white)
                                .padding()
                        }
                        
                        /// Country `Weather Forecast` button
                        Button {
                            showCountryWeatherForecast = true
                        } label: {
                            Image(systemName: "umbrella")
                                .foregroundColor(.white)
                                .padding()
                        }
                        
                        /// Country `Currency Information` button
                        Button {
                            showCountryCurrencyInformation = true
                        } label: {
                            Image(systemName: "dollarsign.circle")
                                .foregroundColor(.white)
                                .padding()
                        }
                        
                    }
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(8)
                    .padding()
                }
                
                Spacer()
                
                // MARK: -
                // MARK: Country Picker
                
                Picker("Select a country", selection: $viewModel.selectedCountry) {
                    Text("Select a country")
                        .foregroundColor(.white)
                    ForEach(viewModel.countries, id: \.self) { country in
                        Text(country.name.common)
                            .foregroundColor(.white)
                    }
                }
                .pickerStyle(.automatic)
                .background(Color.black.opacity(0.7))
                .cornerRadius(8)
                .padding()
                .frame(width: 200)
                .onChange(of: viewModel.selectedCountry) { newCountry in
                    viewModel.pickerSelectionDidChange(with: newCountry)
                }
                
                Spacer()
                
                // MARK: -
                // MARK: Map theme buttons
                
                VStack {
                    Button {
                        showMapTypeOptions = true
                    } label: {
                        Image(systemName: "square.2.layers.3d")
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .background(Color.black.opacity(0.7))
                .cornerRadius(8)
                .padding()
                
            }
        }
        .sheet(isPresented: $showMapTypeOptions) {
            MapTypeOptionsSheetView(mapType: $mapType)
        }
        .sheet(isPresented: $showCountryGeneralInformation) {
            MainSheetView {
                CountryGeneralInformationSheetView(country: viewModel.selectedCountry)
            }
        }
        .sheet(isPresented: $showCountryWeatherInformation) {
            MainSheetView {
                CountryWeatherInformationSheetView(country: viewModel.selectedCountry, viewModel: CountryWeatherInformationSheetViewModel(country: viewModel.selectedCountry))
            }
        }
        .sheet(isPresented: $showCountryWeatherForecast) {
            MainSheetView {
                CountryWeatherForecastSheetView(country: viewModel.selectedCountry, viewModel: CountryWeatherForecastSheetViewModel(country: viewModel.selectedCountry))
            }
        }
        .sheet(isPresented: $showCountryCurrencyInformation) {
            MainSheetView {
                CountryCurrencyInformationSheetView(country: viewModel.selectedCountry, viewModel: CountryCurrencyInformationSheetViewModel(country: viewModel.selectedCountry))
            }
        }
    }
    
    @ViewBuilder
    func showErrorView() -> some View {
        VStack {
            Text("Error, please try again")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapContainerView(viewModel: MapContainerViewModel())
    }
}
