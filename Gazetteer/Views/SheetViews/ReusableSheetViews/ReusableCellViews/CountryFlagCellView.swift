//
//  CountryFlagCellView.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 19/05/2023.
//

import SwiftUI

struct CountryFlagCellView: View {
    let title: String
    let flagUrlString: String
    
    var body: some View {
        HStack {
            Spacer()
            Text("\(title): ")
                .padding()
            AsyncImage(url: URL(string: flagUrlString)) { image in
                image
                    .resizable()
                    .frame(width: 30, height: 30)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            Spacer()
        }
    }
}

