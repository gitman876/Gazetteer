//
//  MapTypeOptionsView.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 02/05/2023.
//

import SwiftUI
import MapKit

struct MapTypeOptionsView: View {
    
    @Binding var mapType: MKMapType
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
            Text("Select a map view")
                .font(.headline)
                .padding()
            
            Divider()
            
            HStack {
                
                Button(action: {
                    mapType = .standard
                    dismiss()
                }) {
                    Image(systemName: "map")
                        .foregroundColor(.white)
                        .padding()
                }
                
                Button(action: {
                    mapType = .satellite
                    dismiss()
                }) {
                    Image(systemName: "globe")
                        .foregroundColor(.white)
                        .padding()
                }
                
                Button(action: {
                    mapType = .hybrid
                    dismiss()
                }) {
                    Image(systemName: "network")
                        .foregroundColor(.white)
                        .padding()
                }
                
                Button(action: {
                    mapType = .satelliteFlyover
                    dismiss()
                }) {
                    Image(systemName: "location.viewfinder")
                        .foregroundColor(.white)
                        .padding()
                }
                
                Button(action: {
                    mapType = .hybridFlyover
                    dismiss()
                }) {
                    Image(systemName: "location.circle.fill")
                        .foregroundColor(.white)
                        .padding()
                }
                
            }
            Spacer()
        }
        .background(Color.black.opacity(0.7))
        .cornerRadius(8)
        .padding()
        .presentationDetents([.height(200)])
    }
}

