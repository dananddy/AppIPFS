//
//  ImageLoader.swift
//  AppIPFS
//
//  Created by busido on 04.12.2023.
//

import SwiftUI

struct ImageLoader: View {
    
    @State var hash: String
    @State var isLoading = false
    @State var isError = false
    @State var data: Data?
    
    var body: some View {
        VStack {
            Text("image")
            Spacer()
            if let data = data, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(isLoading ? 0 : 1)
            }
            Image(systemName: "error")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(isError ? 1 : 0)
        }.onAppear {
            Task {
                isLoading = true
                do {
                    try await loadImg()
                } catch {
                    isError = true
                }
                isLoading = false
            }
        }
    }
    
    func loadImg() async throws {
        self.data = try await IPFSManager.shared.loadImgData(hash)
    }
}
