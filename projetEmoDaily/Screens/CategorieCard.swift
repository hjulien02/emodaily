//
//  CategorieCard.swift
//  projetEmoDaily
//
//  Created by Thomas Jegou on 11/03/2026.
//

//
//  CategorieCard.swift
//  projetEmoDaily
//

import SwiftUI

struct CategorieCard: View {
    let icone: String
    let label: String

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icone)
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(.white)
            Text(label)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, minHeight: 70)
        .background(Color("green4"))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

#Preview {
    CategorieCard(icone: "heart.fill", label: "Émotions")
        .padding()
}
