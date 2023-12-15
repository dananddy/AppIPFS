//
//  ActionButton.swift
//  AppIPFS
//
//  Created by busido on 04.12.2023.
//

import SwiftUI

struct ActionButton: View {
    var text: String
    var image: String
    var body: some View {
        HStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .frame(width: 260, height: 70)
                    .foregroundColor(.blue)
                HStack {
                    Spacer()
                    Text(text)
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: image)
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.white)
                    Spacer()
                }
            }
            Spacer()
        }
    }
}
