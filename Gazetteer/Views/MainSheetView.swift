//
//  SheetView.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 19/05/2023.
//

import SwiftUI

struct MainSheetView<Content: View>: View {
    
    @Environment(\.presentationMode) var presentationMode
    let content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationView {
            content
                .navigationBarItems(trailing: dismissButton)
                .navigationBarTitle(Text(""), displayMode: .inline)
        }
        .background(Color.cyan)
    }
    
    private var dismissButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Done")
                .foregroundColor(Color.black)
        }
    }
}


struct MainSheetView_Previews: PreviewProvider {
    static var previews: some View {
        MainSheetView {
            Text("Hello World")
        }
    }
}
