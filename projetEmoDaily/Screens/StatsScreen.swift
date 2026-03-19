//
//  StatsScreen.swift
//  projetEmoDaily
//
//  Created by Thomas Jegou on 04/03/2026.
//

import SwiftUI

struct StatsScreen: View {

    @State private var moisActuel = "Mars 2026"
    @State private var semaineActuelle = "Semaine 12"
    @State private var jourSelectionne = 20

    @State private var nbEntrees: Int = 0
    @State private var nbChallenges: Int = 0
    @State private var nbTampons: Int = 0
    @State private var isLoading: Bool = true
    @State private var vmUser = UsersViewModel()
    @State private var vmEntries = EntriesViewModel()
    @State private var vmQuest = QuestsViewModel()
    @State private var stamps = [Stamp]()
    @State private var challenges = [Challenge]()
    @State private var popupIndex: Int? = nil

    private let jours: [(lettre: String, numero: Int)] = [
        ("L", 16), ("M", 17), ("M", 18), ("J", 19),
        ("V", 20), ("S", 21), ("D", 22),
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color("bg").ignoresSafeArea()
                VStack {
                    HStack {
                        Title(title: "Statistiques")
                        Spacer()
                        Button {
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundStyle(.black)
                        }
                    }
                    .padding()

                    if isLoading {
                        ProgressView("Chargement...")
                            .tint(Color("text"))
                            .foregroundStyle(Color("text"))
                            .scaleEffect(1.1)
                            .frame(maxHeight: .infinity)
                    } else {
                        VStack(alignment: .leading, spacing: 24) {
                            VStack(spacing: 4) {
                                HStack(spacing: 24) {
                                    Button {
                                    } label: {
                                        Image(systemName: "chevron.left")
                                            .font(
                                                .system(
                                                    size: 16,
                                                    weight: .semibold
                                                )
                                            )
                                            .foregroundStyle(.black)
                                    }
                                    Text(moisActuel)
                                        .font(.title3.weight(.semibold))
                                        .foregroundStyle(.black)
                                    Button {
                                    } label: {
                                        Image(systemName: "chevron.right")
                                            .font(
                                                .system(
                                                    size: 16,
                                                    weight: .semibold
                                                )
                                            )
                                            .foregroundStyle(.black)
                                    }
                                }
                                Text(semaineActuelle)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity)

                            HStack(spacing: 8) {
                                ForEach(jours, id: \.numero) { jour in
                                    Button {
                                        jourSelectionne = jour.numero
                                    } label: {
                                        VStack(spacing: 2) {
                                            Text(jour.lettre)
                                                .font(
                                                    .caption.weight(
                                                        .semibold
                                                    )
                                                )
                                            Text("\(jour.numero)")
                                                .font(
                                                    .caption.weight(.bold)
                                                )
                                        }
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 8)
                                        .background(
                                            jourSelectionne == jour.numero
                                                ? Color("green1")
                                                : Color("green1").opacity(
                                                    0.35
                                                )
                                        )
                                        .clipShape(
                                            RoundedRectangle(
                                                cornerRadius: 10,
                                                style: .continuous
                                            )
                                        )
                                        .foregroundStyle(.black)
                                    }
                                }
                            }
                            .padding(
                                .init(
                                    top: 0,
                                    leading: 16,
                                    bottom: 0,
                                    trailing: 16
                                )
                            )

                            ScrollView {
                                VStack {
                                    HStack {
                                        Text("Mood")
                                            .font(.title3.weight(.semibold))
                                        Spacer()
                                    }
                                    .padding(.bottom)

                                    HStack(spacing: 24) {
                                        ZStack {
                                            Circle()
                                                .trim(from: 0, to: 0.2)
                                                .stroke(
                                                    Color("green4"),
                                                    lineWidth: 20
                                                )
                                                .rotationEffect(.degrees(-90))
                                            Circle()
                                                .trim(from: 0.2, to: 0.4)
                                                .stroke(
                                                    Color("green3"),
                                                    lineWidth: 20
                                                )
                                                .rotationEffect(.degrees(-90))
                                            Circle()
                                                .trim(from: 0.4, to: 0.8)
                                                .stroke(
                                                    Color("green2"),
                                                    lineWidth: 20
                                                )
                                                .rotationEffect(.degrees(-90))
                                            Circle()
                                                .trim(from: 0.8, to: 1)
                                                .stroke(
                                                    Color("green1"),
                                                    lineWidth: 20
                                                )
                                                .rotationEffect(.degrees(-90))
                                        }
                                        .frame(width: 120, height: 120)

                                        VStack(alignment: .leading, spacing: 12)
                                        {
                                            MoodStat(
                                                color: Color("green2"),
                                                percentage: "40%",
                                                emoji: "😑"
                                            )
                                            MoodStat(
                                                color: Color("green3"),
                                                percentage: "20%",
                                                emoji: "😴"
                                            )
                                            MoodStat(
                                                color: Color("green4"),
                                                percentage: "20%",
                                                emoji: "🙂"
                                            )
                                            MoodStat(
                                                color: Color("green4"),
                                                percentage: "20%",
                                                emoji: "😥"
                                            )
                                        }
                                        Spacer()
                                    }
                                    .padding(
                                        .init(
                                            top: 0,
                                            leading: 16,
                                            bottom: 0,
                                            trailing: 16
                                        )
                                    )

                                    LazyVGrid(
                                        columns: [
                                            GridItem(.flexible()),
                                            GridItem(.flexible()),
                                        ],
                                        spacing: 14
                                    ) {
                                        Button {
                                            popupIndex = 0
                                        } label: {
                                            CategoryCard(
                                                icon: "bed.double.fill",
                                                label: "Sommeil"
                                            )
                                        }
                                        Button {
                                            popupIndex = 1
                                        } label: {
                                            CategoryCard(
                                                icon: "fork.knife",
                                                label: "Appetit"
                                            )
                                        }
                                        Button {
                                            popupIndex = 2
                                        } label: {
                                            CategoryCard(
                                                icon: "bolt.fill",
                                                label: "Énergie"
                                            )
                                        }
                                        Button {
                                            popupIndex = 3
                                        } label: {
                                            CategoryCard(
                                                icon: "waveform.path.ecg",
                                                label: "Anxiété"
                                            )
                                        }
                                    }
                                    .padding(.top, 30)

                                    HStack(spacing: 10) {
                                        StatBottom(
                                            label: "Entrées",
                                            value: "\(nbEntrees)"
                                        )
                                        StatBottom(
                                            label: "Défis",
                                            value: "\(nbChallenges)"
                                        )
                                        StatBottom(
                                            label: "Tampons",
                                            value: "\(nbTampons)"
                                        )
                                    }
                                    .padding(.top, 14)
                                }
                                .padding(.horizontal, 25)
                                .padding(.top, 8)
                                .padding(.bottom, 32)
                            }
                            .scrollIndicators(.hidden)
                        }
                    }
                }
                if let index = popupIndex {
                    StatPopup(
                        onClose: { popupIndex = nil },
                        currentIndex: index,
                        nextIndex: {
                            if index < 3 {
                                popupIndex = index + 1
                            }
                        },
                        prevIndex: {
                            if index > 0 {
                                popupIndex = index - 1
                            }
                        },
                        hasPrev: index > 0,
                        hasNext: index < 3
                    )
                }
            }
            .task {
                isLoading = true
                do {
                    try await vmUser.fetchUsers()
                } catch {
                    print(error)
                }
                nbEntrees = vmUser.connectedUser.entries!.count

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
                    challenges = result.compactMap { $0 as? Challenge }
                    nbChallenges =
                        challenges.filter { challenge in
                            challenge.isCompleted == true
                        }.count
                    nbTampons = stamps.count
                }
                isLoading = false
            }
        }
    }
}

#Preview {
    StatsScreen()
}
