//
//  MoodStat 2.swift
//  projetEmoDaily
//
//  Created by Thomas Jegou on 12/03/2026.
//
import SwiftUI

struct MoodStat: View {
    let couleur: Color
    let pourcentage: String
    let emoji: String

    var body: some View {
        HStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 4)
                .fill(couleur)
                .frame(width: 22, height: 22)
            Text(pourcentage)
                .font(.subheadline.weight(.semibold))
            Text(emoji)
        }
    }
}
