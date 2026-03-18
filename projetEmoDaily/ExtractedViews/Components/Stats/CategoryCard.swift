
//  CategoryCard.swift
//  projetEmoDaily
//
//  Created by Thomas Jegou on 11/03/2026.
//

import SwiftUI

struct CategoryCard: View {
    let icon: String
    let label: String

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
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
    CategoryCard(icon: "heart.fill", label: "Émotions")
        .padding()
}
