//
//  MapView.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 02/05/2023.
//

import SwiftUI
import MapKit

struct MapUIViewRepresentable: UIViewRepresentable {
    
    var region: MKCoordinateRegion
    @Binding var mapType: MKMapType

    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
        uiView.showsUserLocation = true
        uiView.mapType = mapType
    }
    
}

