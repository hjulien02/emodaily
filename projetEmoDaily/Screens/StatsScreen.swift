//  EcranStats.swift
//  projetEmoDaily

import SwiftUI

struct StatsScreen: View {

    @State private var moisActuel = "Mars 2026"
    @State private var semaineActuelle = "Semaine 10"
    @State private var jourSelectionne = 10

    @State private var nbEntrees: Int = 0
    @State private var nbChallenges: Int = 0
    @State private var nbTampons: Int = 0
    @State private var isLoading: Bool = true
    @State private var vmUser = UsersViewModel()
    @State private var vmEntries = EntriesViewModel()
    @State private var vmQuest = QuestsViewModel()
    @State private var stamps = [Stamp]()
    @State private var challenges = [Challenge]()
    @State private var popupOpenedSleep: Bool = false
    @State private var popupOpenedEnergy: Bool = false
    @State private var popupOpenedEat: Bool = false
    @State private var popupOpenedAnxiety: Bool = false



    private let jours: [(lettre: String, numero: Int)] = [
        ("L", 17), ("M", 18), ("M", 19), ("J", 20),
        ("V", 21), ("S", 22), ("D", 23),
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
                        ScrollView {
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

                                Text("Mood")
                                    .font(.title3.weight(.semibold))

                                HStack(spacing: 24) {
                                    ZStack {
                                        Circle()
                                            .trim(from: 0, to: 0.7)
                                            .stroke(
                                                Color("green4"),
                                                lineWidth: 20
                                            )
                                            .rotationEffect(.degrees(-90))
                                        Circle()
                                            .trim(from: 0.7, to: 0.9)
                                            .stroke(
                                                Color("green3"),
                                                lineWidth: 20
                                            )
                                            .rotationEffect(.degrees(-90))
                                        Circle()
                                            .trim(from: 0.9, to: 1.0)
                                            .stroke(
                                                Color("green2"),
                                                lineWidth: 20
                                            )
                                            .rotationEffect(.degrees(-90))
                                    }
                                    .frame(width: 120, height: 120)

                                    VStack(alignment: .leading, spacing: 12) {
                                        MoodStat(
                                            couleur: Color("green2"),
                                            pourcentage: "10%",
                                            emoji: "😊"
                                        )
                                        MoodStat(
                                            couleur: Color("green3"),
                                            pourcentage: "20%",
                                            emoji: "😐"
                                        )
                                        MoodStat(
                                            couleur: Color("green4"),
                                            pourcentage: "70%",
                                            emoji: "😔"
                                        )
                                    }
                                    Spacer()
                                }
                                .padding(.top, 10)

                                LazyVGrid(
                                    columns: [
                                        GridItem(.flexible()),
                                        GridItem(.flexible()),
                                    ],
                                    spacing: 14
                                ) {
                                    Button {
                                        popupOpenedSleep = true
                                    } label: {
                                        CategorieCard(
                                            icone: "bed.double.fill",
                                            label: "Sommeil"
                                        )
                                    }
                                    Button {
                                        popupOpenedEat = true
                                    } label: {
                                        CategorieCard(
                                            icone: "fork.knife",
                                            label: "Appetit"
                                        )
                                    }
                                    Button {
                                        popupOpenedEnergy = true
                                    } label: {
                                        CategorieCard(
                                            icone: "bolt.fill",
                                            label: "Énergie"
                                        )
                                    }
                                    Button {
                                        popupOpenedAnxiety = true
                                    } label: {
                                        CategorieCard(
                                            icone: "waveform.path.ecg",
                                            label: "Anxiété"
                                        )
                                    }
                                }
                                .padding(.top, 30)

                                HStack(spacing: 10) {
                                    StatBottom(
                                        label: "Entrées",
                                        valeur: "\(nbEntrees)"
                                    )
                                    StatBottom(
                                        label: "Challenges",
                                        valeur: "\(nbChallenges)"
                                    )
                                    StatBottom(
                                        label: "Tampons",
                                        valeur: "\(nbTampons)"
                                    )
                                }
                                .padding(.top, 14)
                            }
                            .padding(.horizontal, 25)
                            .padding(.top, 8)
                            .padding(.bottom, 32)
                        }
                    }
                }
                if popupOpenedSleep {
                    StatPopupSleep(onClose: {
                        popupOpenedSleep = false
                    })
                
                }
                
                if popupOpenedEnergy {
                    StatPopupEnergy(onClose: {
                        popupOpenedEnergy = false
                    })
                
                }
                
                if popupOpenedEat {
                    StatPopupEat(onClose: {
                        popupOpenedEat = false
                    })
                
                }
                
                if popupOpenedAnxiety {
                    StatPopupAnxiety(onClose: {
                        popupOpenedAnxiety = false
                    })
                
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
