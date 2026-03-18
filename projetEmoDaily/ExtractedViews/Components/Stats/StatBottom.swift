
//  StatBottom.swift
//  projetEmoDaily
//
//  Created by Thomas Jegou on 11/03/2026.
//


import SwiftUI

struct StatBottom: View {
    let label: String
    let value: String

    var body: some View {
        VStack(spacing: 2) {
            Text(label)
                .font(.caption.weight(.semibold))
            Text(value)
                .font(.subheadline.weight(.bold))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(Color("green1").opacity(0.45))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .foregroundStyle(.black)
    }
}


#Preview {
    StatBottom(label: "singe", value: "4")
}

