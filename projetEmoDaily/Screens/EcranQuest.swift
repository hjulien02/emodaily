//
//  EcranQuest.swift
//  projetEmoDaily
//
//  Created by Apprenent 151 on 04/03/2026.
//

import SwiftUI

struct EcranQuest: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.bg.ignoresSafeArea()
                VStack {
                    Title(title: "Quêtes")
                    NavigationLink {
                        EcranDefis()
                    } label: {
                        QuestMenu(questTitle: "Défis", questDescription: "Mettez-vous au défi, seul ou à plusieurs!", questImage: "challengesMenu")
                            .padding(.bottom)
                    }
                    NavigationLink {
                        EcranStamp()
                    } label: {
                        QuestMenu(questTitle: "Tampons", questDescription: "Consultez vos accomplisements!", questImage: "stampsMenu")
                            .padding(.top)
                    }
                }
                .foregroundStyle(.text)
                .padding()
            }
        }
    }
}

#Preview {
    EcranQuest()
}
