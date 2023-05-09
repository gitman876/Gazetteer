//
//  MapTypeOptionsView.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 02/05/2023.
//

import SwiftUI
import MapKit

struct MapTypeOptionsSheetView: View {
    
    @Binding var mapType: MKMapType
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            
            Text("Select a map view")
                .font(.headline)
                .padding()
            
            Divider()
            
            HStack {
                MapTypeButton(mapType: .standard, buttonAction: selectMapType)
                Divider()
                MapTypeButton(mapType: .satellite, buttonAction: selectMapType)
                Divider()
                MapTypeButton(mapType: .hybrid, buttonAction: selectMapType)
                Divider()
                MapTypeButton(mapType: .satelliteFlyover, buttonAction: selectMapType)
                Divider()
                MapTypeButton(mapType: .hybridFlyover, buttonAction: selectMapType)
            }
            Spacer()
        }
        .background(Color.black.opacity(0.7))
        .cornerRadius(8)
        .presentationDetents([.height(200)])
    }
    
    private func selectMapType(_ selectedMap: MKMapType) {
        self.mapType = selectedMap
        self.presentationMode.wrappedValue.dismiss()
    }
    
}

struct MapTypeButton: View {
    
    let mapType: MKMapType
    let buttonAction: (MKMapType) -> Void
    
    var body: some View {
        Button {
            buttonAction(mapType)
        } label: {
            VStack {
                self.getImge(for: mapType)
                    .foregroundColor(.white)
                    .padding()
                self.getTitle(for: mapType)
                    .foregroundColor(.white)
            }
        }

    }
    
    private func getImge(for mapType: MKMapType) -> Image {
        switch mapType {
            case .standard:
                return Image(systemName: "map")
            case .satellite:
                return Image(systemName: "globe")
            case .hybrid:
                return Image(systemName: "network")
            case .satelliteFlyover:
                return Image(systemName: "location.viewfinder")
            case .hybridFlyover:
                return Image(systemName: "location.circle.fill")
            case .mutedStandard:
                return Image(systemName: "questionmark")
            @unknown default:
                return Image(systemName: "questionmark")
        }
    }
    
    private func getTitle(for mapType: MKMapType) -> Text {
        switch mapType {
            case .standard:
                return Text("Standard")
            case .satellite:
                return Text("Satellite")
            case .hybrid:
                return Text("Hybrid")
            case .satelliteFlyover:
                return Text("Satellite Flyover")
            case .hybridFlyover:
                return Text("Hybrid Flyover")
            case .mutedStandard:
                return Text("Muted Standard")
            @unknown default:
                return Text("Unknown")
        }
    }
    
}

