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
    
    func filterChallenges() -> [Challenge] {
        switch selectedPeriod {
        case "Collectif":
            return challenges.filter { challenge in
                challenge.challengeType == .multi
            }
        case "Mes défis":
            return challenges.filter { challenge in
                challenge.progress > 0
            }
        default:
            return challenges.filter { challenge in
                challenge.challengeType == .solo
            }
        }
    }

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
                    ForEach(filterChallenges()) { challenge in
                        Defi(challenge: challenge)
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
