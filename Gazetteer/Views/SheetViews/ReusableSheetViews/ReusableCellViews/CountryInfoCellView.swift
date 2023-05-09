//
//  CountryInfoCellView.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 19/05/2023.
//

import SwiftUI

struct CountryInfoCellView: View {
    let title: String
    let detail: String
    
    var body: some View {
        HStack {
            Spacer()
            Text("\(title): ")
                .padding()
            Text(detail)
            Spacer()
        }
    }
}
