//
//  PhotoPresenter.swift
//  AppIPFS
//
//  Created by busido on 04.12.2023.
//

import Foundation
import SwiftUI

struct PhotoPresenter: View {
    var body: some View {
        let hashes = HashStorage.shared.getHashes()
        List(hashes) { hash in
            NavigationLink {
                ImageLoader(hash: hash.hash)
            } label:{
                HStack {
                    Text("image")
                    Text(hash.hash)
                        .foregroundStyle(.gray)
                        .truncationMode(.middle)
                }
            }
        }
        .navigationTitle("Images")
    }
}
