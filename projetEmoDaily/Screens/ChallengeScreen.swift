//
//  ChallengeScreen.swift
//  projetEmoDaily
//
//  Created by Apprenent 151 on 10/03/2026.
//

import SwiftUI

struct ChallengeScreen: View {
    @State var selectedPeriod = "Individuel"
    @State var defisType = ["Individuel", "Collectif", "Mes défis"]
    @State var vmQuest = QuestsViewModel()
    @State var vmUser = UsersViewModel()
    @State var challenges = [Challenge]()
    @State var isLoading = true
    
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
                HStack {
                    ForEach(defisType, id: \.self) { type in
                        PickerButton(
                            text: type,
                            selectedPicker: $selectedPeriod
                        )
                    }
                }
                
                if (isLoading) {
                    ProgressView("Chargement...")
                        .tint(Color("text"))
                        .foregroundStyle(Color("text"))
                        .scaleEffect(1.1)
                        .frame(maxHeight: .infinity)
                } else {
                    ScrollView {
                        VStack (spacing: 20) {
                            ForEach(filterChallenges()) { challenge in
                                DefiComponent(challenge: challenge)
                            }
                        }
                    }
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    ChildScreenTitle(title: "Défis")
                }
            }
            .task {
                isLoading = true
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
                isLoading = false
            }
        }
    }
}

#Preview {
    ChallengeScreen()
}
