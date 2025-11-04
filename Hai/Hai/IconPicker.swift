//
//  IconPicker.swift
//  Hai
//
//  Created by Victor Noagbodji on 11/1/25.
//

import SwiftUI

struct IconPicker: View {
    @Binding var avatar: String
    @Environment(\.dismiss) private var dismiss

    let columns = Array(repeating: GridItem(.flexible()), count: 6)
    
    let icons: [String] = (0x1F600...0x1F66D).compactMap { UnicodeScalar($0) }.map { String($0) }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(icons, id: \.self) { icon in
                    Text(icon)
                        .font(.custom("Fontaku", size: 40))
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.2))
                        )
                        .onTapGesture {
                            avatar = icon
                            dismiss()
                        }
                }
            }
            .padding()
        }
        .frame(width: 500, height: 400)
    }
}
