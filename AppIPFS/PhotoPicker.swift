//
//  PhotoPicker.swift
//  AppIPFS
//
//  Created by busido on 04.12.2023.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: View {
    @State var selectedItems: [PhotosPickerItem] = []
    @State var isSaveHidden = true
    @State var doneLoading = false
    @State var data: Data?
    @State var isLoading = false
    @State var showError = false
    
    var body: some View {
        Spacer()
            .opacity(isLoading ? 0 : 1)
        if let data = data, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(isLoading ? 0 : 1)
        }
        Image(systemName: "square.and.arrow.up.trianglebadge.exclamationmark")
            .opacity(showError ? 1 : 0)
        PhotosPicker(selection: $selectedItems,
                     maxSelectionCount: 1,
                     matching: .images) {
            ActionButton(text: "pick image", image: "photo.on.rectangle")
        }.onChange(of: selectedItems) { newItem in
            guard let item = selectedItems.first else {
                return
            }
            item.loadTransferable(type: Data.self) { result in
                switch result {
                case .success(let data):
                    self.data = data
                    self.isSaveHidden.toggle()
                case .failure(_):
                    fatalError()
                }
            }
        }.opacity(doneLoading ? 0 : 1)
        ProgressView()
            .opacity(isLoading ? 1 : 0)
        Button {
            Task {
                isLoading = true
                isSaveHidden = true
                do {
                    try await loadImg()
                } catch {
                    showError = true
                }
                isLoading = false
                doneLoading = true
                isSaveHidden = true
            }
        } label: {
            ActionButton(text: "Save Photo", image: "")
        }.opacity(isSaveHidden ? 0 : 1)
        Image(systemName: "globe.europe.africa.fill")
            .foregroundStyle(.green)
            .opacity(doneLoading ? 1 : 0)
    }
    
    func loadImg() async throws {
        if let data = data {
            let responseHash = try await IPFSManager.shared.saveImgData(data)
            HashStorage.shared.saveHash(responseHash)
        }
    }
}
