//
//  EcranDefis.swift
//  projetEmoDaily
//
//  Created by Apprenent 151 on 10/03/2026.
//

import SwiftUI

struct EcranDefis: View {
    @State var selectedPeriod = "Individuel"
    @State var defisType = ["Individuel", "Collectif", "Mes défis"]
    @State var vmQuest = QuestsViewModel()
    @State var vmUser = UsersViewModel()
    @State var challenges = [Challenge]()

    var body: some View {
        ZStack {
            Color.bg.ignoresSafeArea()
            VStack(spacing: 20) {
                Title(title: "Défis")
                HStack {
                    ForEach(defisType, id: \.self) { type in
                        PickerButton(
                            text: type,
                            selectedPicker: $selectedPeriod
                        )
                    }
                }

                ScrollView {
                    ForEach(challenges) { challenge in
                        Defi(
                            title: challenge.title,
                            description: challenge.questDescription,
                            emoji: challenge.image,
                            startDate: challenge.startDate,
                            endDate: challenge.endDate,
                            progress: challenge.progress,
                            total: challenge.total
                        )
                    }
                }
            }
            .padding()
            .task {
                do {
                    try await vmUser.fetchUsers()
                } catch {
                    print(error)
                }
                if let quests = vmUser.connectedUser.quests {
                    var result = [Quest]()
                    for questId in quests {
                        do {
                            let quest = try await vmQuest.fetchQuestByID(
                                id: questId
                            )
                            result.append(quest)
                        } catch {
                            print(error)
                        }
                    }
                    challenges = result.compactMap { $0 as? Challenge }
                }
            }
        }
    }
}

#Preview {
    EcranDefis()
}
