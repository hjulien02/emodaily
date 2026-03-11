//
//  EcranNouvelleEntree.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 04/03/2026.
//

import SwiftUI

struct EcranNouvelleEntree: View {

    @State var entry: Entry
    @State var date: Date

    var rows = [
        GridItem(.adaptive(minimum: 24), spacing: 16),
        GridItem(.adaptive(minimum: 24), spacing: 16),
    ]
    var columns = [GridItem(.flexible()), GridItem(.flexible())]

    let anxietyValues = AnxietyLevel.allCases.map { $0.rawValue }
    let anxietyIcons = AnxietyLevel.allCases.map { $0.getSymbol() }
    @State var anxietyIndex = 0

    let energyValues = EnergyLevel.allCases.map { $0.rawValue }
    let energyIcons = EnergyLevel.allCases.map { $0.getSymbol() }
    @State var energyIndex = 0

    let appetiteValues = AppetiteLevel.allCases.map { $0.rawValue }
    let appetiteIcons = AppetiteLevel.allCases.map { $0.getSymbol() }
    @State var appetiteIndex = 0

    let sleepValues = SleepLevel.allCases.map { $0.rawValue }
    let sleepIcons = SleepLevel.allCases.map { $0.getSymbol() }
    @State var sleepIndex = 0

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            VStack(spacing: 36) {
                Text("Nouvelle Entrée")  //Titre
                //                    .offset(y: -24)

                //Bornes du picker
                let daysBefore = Calendar.current.date(
                    byAdding: .day,
                    value: -7,
                    to: Date.now
                )!
                let daysAfter = Calendar.current.date(
                    byAdding: .day,
                    value: 7,
                    to: Date.now
                )!

                //Picker pour changer la date
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.green4, lineWidth: 1)
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .center
                        )

                    HStack {
                        Spacer()
                        Text("Pour le :")
                            .foregroundStyle(.green4)
                            .font(.system(size: 12))

                        DatePicker(
                            "",
                            selection: $date,
                            in: daysBefore...daysAfter,
                            displayedComponents: [.date]
                        )
                        .fixedSize()
                        .tint(.green4)
                    }
                }
                .frame(maxWidth: 195, maxHeight: 12)

                //Contenu de l'entrée
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {

                        //SECTION EMOTION
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Comment s’est passée ta journée ?")

                            VStack {
                                LazyHGrid(rows: rows, spacing: 24) {
                                    ForEach(Emotion.allCases) {
                                        thisEmotion in

                                        EmotionButton(
                                            entry: entry,
                                            emotion: thisEmotion,
                                            emoji: thisEmotion.getEmoji()
                                        )
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 20).fill(
                                    .green15
                                )
                                .stroke(.green4.opacity(0.1), lineWidth: 2)
                            )

                        }  //SECTION EMOTION
                        .frame(maxWidth: .infinity)

                        //SECTION OPTIONS
                        VStack(alignment: .leading, spacing: 12) {
                            VStack(alignment: .leading) {
                                Text("Quelque chose à raconter ?")
                                Text("seulement si tu le veux...")
                                    .font(.system(size: 12))
                            }

                            LazyVGrid(columns: columns) {
                                EntryOption(
                                    icone: "character.circle.fill",
                                    optionTitle: "note"
                                )
                                EntryOption(
                                    icone: "photo.circle.fill",
                                    optionTitle: "photo"
                                )
                            }

                        }  //SECTION OPTIONS
                        .frame(maxWidth: .infinity)

                        //SECTION SANTE
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Et ta santé dans l’histoire ?")

                            VStack(spacing: 22) {
                                HealthSlider(
                                    entry: entry,
                                    message: "Es-tu anxieux.se ?",
                                    healthLevels: anxietyValues,
                                    healthIcons: anxietyIcons,
                                    selectedLevel: $anxietyIndex
                                )
                                HealthSlider(
                                    entry: entry,
                                    message: "Comment te sens-tu ?",
                                    healthLevels: energyValues,
                                    healthIcons: energyIcons,
                                    selectedLevel: $energyIndex
                                )
                                HealthSlider(
                                    entry: entry,
                                    message: "As-tu de l’appétit?",
                                    healthLevels: appetiteValues,
                                    healthIcons: appetiteIcons,
                                    selectedLevel: $appetiteIndex
                                )
                                HealthSlider(
                                    entry: entry,
                                    message: "Comment s’est passé ta nuit ?",
                                    healthLevels: sleepValues,
                                    healthIcons: sleepIcons,
                                    selectedLevel: $sleepIndex
                                )
                            }

                        }  //SECTION SANTE
                        .frame(maxWidth: .infinity, alignment: .leading)

                        // CTA
                        Button {
                            entry.anxiety = AnxietyLevel.allCases[anxietyIndex]
                            entry.energy = EnergyLevel.allCases[energyIndex]
                            entry.appetite =
                                AppetiteLevel.allCases[appetiteIndex]
                            entry.sleep = SleepLevel.allCases[sleepIndex]
                        } label: {
                            Text("Enregistrer")
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(
                            RoundedRectangle(cornerRadius: 20).fill(.green4)
                                .stroke(.green15.opacity(0.4), lineWidth: 2)
                        )
                        .foregroundStyle(Color.white)
                        .bold()

                    }
                    .padding(.horizontal, 24)
                }
            }
        }
    }
}

#Preview {
    EcranNouvelleEntree(entry: entriesData[0], date: entriesData[0].date)
}
