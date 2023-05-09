//
//  MainSheetHeaderView.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 19/05/2023.
//

import SwiftUI

struct MainSheetHeaderView: View {
    
    let country: Country
    let description: String
    
    var body: some View {
        HStack {
            Text("\(description) \(country.name.common)")
                .font(.headline)
            AsyncImage(url: URL(string: country.flags.png)) { image in
                image
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
        }
        .padding()
    }
}
