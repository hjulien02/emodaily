//
//  StampScreen.swift
//  projetEmoDaily
//
//  Created by Apprenent 151 on 11/03/2026.
//

import SwiftUI

struct StampScreen: View {
    @State var vmQuest = QuestsViewModel()
    @State var vmUser = UsersViewModel()
    @State var stamps = [Stamp]()
    @State var selectedStampIndex: Int? = nil
    @State var isLoading = true

    var body: some View {
        ZStack {
            Color.bg.ignoresSafeArea()
            VStack(spacing: 20) {

                if isLoading {
                    ProgressView("Chargement...")
                        .tint(Color("text"))
                        .foregroundStyle(Color("text"))
                        .scaleEffect(1.1)
                        .frame(maxHeight: .infinity)
                } else {
                    ScrollView {
                        Text(
                            "Nombre de tampons: \(stamps.map { $0.level }.reduce(0,+))"
                        )
                        .font(.title)
                        .bold()
                        .padding()
                        VStack(spacing: 20) {
                            ForEach(stamps.indices, id: \.self) { index in
                                Button {
                                    selectedStampIndex = index
                                } label: {
                                    StampComponent(stamp: stamps[index])
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .foregroundStyle(Color("text"))

            if let index = selectedStampIndex {
                StampPopup(
                    stamp: stamps[index],
                    onClose: { selectedStampIndex = nil },
                    nextIndex: {
                        if index < stamps.count - 1 {
                            selectedStampIndex = index + 1
                        }
                    },
                    prevIndex: {
                        if index > 0 {
                            selectedStampIndex = index - 1
                        }
                    },
                    hasPrev: index > 0,
                    hasNext: index < stamps.count - 1
                )
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                ChildScreenTitle(title: "Tampons")
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
                stamps = result.compactMap { $0 as? Stamp }
            }
            isLoading = false
        }
    }
}

#Preview {
    StampScreen()
}
