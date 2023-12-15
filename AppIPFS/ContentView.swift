//
//  ContentView.swift
//  AppIPFS
//
//  Created by busido on 02.12.2023.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    var body: some View {
        NavigationView {

            VStack {
                Text("Andriychuk Bohdan")
                Text("KIm-22-1")
                NavigationLink {
                    PhotoPresenter()
                } label: {
                    ActionButton(text: "load photo", image: "square.and.arrow.up")
                }
                
                NavigationLink {
                    PhotoPicker()
                } label: {
                    ActionButton(text: "save photo", image: "square.and.arrow.down")
                }

            }
            .offset(y: 150)
            Spacer()
            
        }.navigationTitle("IPFS")
    }
}

#Preview {
    ContentView()
}
