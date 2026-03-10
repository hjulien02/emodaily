//
//  EcranDefis.swift
//  projetEmoDaily
//
//  Created by Apprenent 151 on 04/03/2026.
//

import SwiftUI

struct EcranQuest: View {
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            VStack {
                Title(title: "Quêtes")
                QuestMenu(questTitle: "Défis", questDescription: "Mettez-vous au défi, seul ou à plusieurs!", questImage: "challengesMenu")
                    .padding()
                QuestMenu(questTitle: "Tampons", questDescription: "Consultez vos accomplisements!", questImage: "stampsMenu")
                    .padding()
            }
        }
    }
}

#Preview {
    EcranQuest()
}
