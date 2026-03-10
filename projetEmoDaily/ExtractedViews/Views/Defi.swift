//
//  Defi.swift
//  projetEmoDaily
//
//  Created by Apprenent 151 on 10/03/2026.
//

import SwiftUI

struct Defi: View {
    let title: String
    let description: String
    let emoji: String
    let startDate: Date?
    let endDate: Date?
    let progress: Int
    let total: Int // >0
    
    let barWidth: CGFloat = 150
    var progressBar: CGFloat {
        CGFloat(progress) / CGFloat(total)
    }
    var ratio: CGFloat {
        min(progressBar, 1)
    }
    
    var body: some View {
        VStack (spacing: 0) {
            // 1/2
            HStack {
                VStack (spacing: 10) {
                    Text(title)
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(description)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Text(emoji)
                    .font(.system(size: 64))
                    .frame(maxWidth: 96)
            }
            .padding(.init(top: 15, leading: 15, bottom: 10, trailing: 15))
            // 2/2
            HStack {
                Image(systemName: "calendar")
                // if startDate & endDate existent, alors on met la date, sinon on met "pas de limite"
                Text("Pas de limite")
                    .frame(maxWidth: 120)
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: barWidth, height: 14)
                        .foregroundStyle(Color.text.opacity(0.2))
                    // superposer un RoundedRectangle montrant la progression
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 150 * ratio, height: 14)
                        .foregroundStyle(Color.green4)
                }
                Text("\(progress)/\(total)")
                    .bold()
                    .frame(maxWidth: 60)
            }
            .padding(.init(top: 10, leading: 15, bottom: 15, trailing: 15))
            .font(.system(size: 14))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .background(Color.green15)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    Defi(title: "Streak 5 Jours", description: "Enregistrez 5 entrées consécutives!", emoji: "🔥", startDate: nil, endDate: nil, progress: 0, total: 5)
}
