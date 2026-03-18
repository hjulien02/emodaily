//
//  QuestMenu.swift
//  projetEmoDaily
//
//  Created by Apprenent 151 on 10/03/2026.
//

import SwiftUI

struct QuestMenu: View {
    let questTitle: String
    let questDescription: String
    let questImage: String
    
    var body: some View {
        VStack (spacing: 0) {
            Image(questImage)
                .resizable()
                .scaledToFill()
                .opacity(0.7)
                .frame(height: 180)
                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 20, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 20))
            VStack (spacing: 0) {
                Text(questTitle)
                    .font(.title)
                    .bold()
                    .padding(.init(top: 10, leading: 10, bottom: 5, trailing: 10))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(questDescription)
                    .padding(.init(top: 5, leading: 10, bottom: 10, trailing: 10))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.green15)
            .clipShape(UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 20, bottomTrailingRadius: 20, topTrailingRadius: 0))
        }
    }
}

#Preview {
    QuestMenu(questTitle: "Défis", questDescription: "Mettez-vous au défi, seul ou à plusieurs!", questImage: "challengesMenu")
}
