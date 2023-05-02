//
//  ContentView.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 25/04/2023.
//

import SwiftUI
import MapKit

struct MapContainerView: View {
    
    @State private var mapType: MKMapType = .standard
    @State private var showMapTypeOptions = false
    @State private var selectedCountry = Country(name: Name(common: ""), cca2: "", latlng: [1, 44])
    
    @StateObject var viewModel: MapContainerViewModel

    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            
            MapUIViewRepresentable(region: viewModel.region, mapType: $mapType)
                .edgesIgnoringSafeArea(.all)

            HStack(alignment: .top) {
                
                // MARK: -
                // MARK: Zoom in-out buttons
                
                VStack {
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
                
                Spacer()
                
                // MARK: -
                // MARK: Country Picker
                
                Picker("Select a country", selection: $selectedCountry) {
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
                .onChange(of: selectedCountry) { newCountry in
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
        .onAppear {
            viewModel.fetchCountryNames()
            viewModel.checkIfLocationServicesIsEnabled()
        }
        .sheet(isPresented: $showMapTypeOptions) {
            MapTypeOptionsView(mapType: $mapType)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapContainerView(viewModel: MapContainerViewModel())
    }
}
