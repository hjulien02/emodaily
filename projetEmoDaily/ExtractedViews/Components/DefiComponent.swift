//
//  DefiComponent.swift
//  projetEmoDaily
//
//  Created by Apprenent 151 on 10/03/2026.
//

import SwiftUI

struct DefiComponent: View {
    let challenge: Challenge
    
    // barre de progression (130px) et ratio
    let barWidth: CGFloat = 130
    var ratio: CGFloat {
        min((CGFloat(challenge.progress) / CGFloat(challenge.total)), 1)
    }
    
    // formatte la date de début/fin d'un challenge (si existante)
    func formatRange(start: Date, end: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        formatter.locale = Locale(identifier: "fr_FR")
        
        return "\(formatter.string(from: start)) - \(formatter.string(from: end))"
    }
    
    var body: some View {
        VStack (spacing: 0) {
            // 1/2: titre/description/image
            HStack {
                VStack (spacing: 10) {
                    Text(challenge.title)
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(challenge.questDescription)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Text(challenge.image)
                    .font(.system(size: 64))
                    .frame(maxWidth: 96)
            }
            .padding(.init(top: 15, leading: 15, bottom: 10, trailing: 15))
            
            // 2/2: calendrier et progression
            HStack {
                Image(systemName: "calendar")
                
                // si le challenge possède un début/une fin datée, l'affiche, sinon affiche "pas de limite"
                if let startDate = challenge.startDate, let endDate = challenge.endDate {
                    Text(formatRange(start: startDate, end: endDate))
                        .frame(maxWidth: 120)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                } else {
                    Text("Pas de limite")
                        .frame(maxWidth: 120)
                }
                
                // barre de progression
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: barWidth, height: 14)
                        .foregroundStyle(Color.text.opacity(0.2))
                    // superposer un RoundedRectangle montrant la progression
                    if (challenge.progress > 0) {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: max(barWidth * ratio, 4), height: 14)
                            .foregroundStyle(Color.green4)
                    }
                }
                
                Text("\(challenge.progress)/\(challenge.total)")
                    .bold()
                    .frame(maxWidth: 60)
                
            }
            .padding(.init(top: 10, leading: 15, bottom: 15, trailing: 15))
            .font(.system(size: 14))
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .frame(maxWidth: .infinity)
        .background(challenge.challengeType == .solo ? Color.green15 : .orange.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    DefiComponent(challenge: Challenge(id: "1", title: "Streak 5 Jours", questDescription: "Enregistrez 5 entrées consécutives!", progress: 1, total: 10, questType: "challenge", challengeType: .multi, image: "🔥", startDate: Date(), endDate: Date().addingTimeInterval(60*60*24*280), isCompleted: false))
}
