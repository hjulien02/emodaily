//
//  MoodStat 2.swift
//  projetEmoDaily
//
//  Created by Thomas Jegou on 12/03/2026.
//
import SwiftUI

struct MoodStat: View {
    let color: Color
    let percentage: String
    let emoji: String

    var body: some View {
        HStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 4)
                .fill(color)
                .frame(width: 22, height: 22)
            Text(percentage)
                .font(.subheadline.weight(.semibold))
            Text(emoji)
        }
    }
}
