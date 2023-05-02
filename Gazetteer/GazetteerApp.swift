//
//  GazetteerApp.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 25/04/2023.
//

import SwiftUI

@main
struct GazetteerApp: App {
    var body: some Scene {
        WindowGroup {
            MapContainerView(viewModel: MapContainerViewModel())
        }
    }
}
