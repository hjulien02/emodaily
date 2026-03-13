//
//  EcranNouvelleEntree.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 04/03/2026.
//

import SwiftUI

struct EcranNouvelleEntree: View {
    
    @Binding var currentEntry: Entry
    
    @State var date: Date

    var rows = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    @State private var showingNotePopover = false
    @State private var showingPicturePopover = false

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
                    value: 0,
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
                        EntrySection(title: "Comment s’est passée ta journée ?"){

                            GreenContainer{
                                LazyHGrid(rows: rows) {
                                    ForEach(Emotion.allCases) {
                                        thisEmotion in

                                        EmotionButton(
                                            entry: currentEntry,
                                            emotion: thisEmotion, emotionText: thisEmotion.rawValue,
                                            emoji: thisEmotion.getEmoji()
                                        )
                                    }
                                }
                            }
                        }  //SECTION EMOTION


                        //SECTION OPTIONS
                        EntrySection(title: "Quelque chose à raconter ?", subtitle: "Seulement si tu le veux..."){

                            LazyVGrid(columns: columns) {
                                    Button{
                                        showingNotePopover = true
                                    }label: {
                                    if currentEntry.notes! == "" {
                                        EntryOption(
                                            icon: "character.circle.fill",
                                            optionTitle: "note"
                                        )
                                    } else {
                                        FilledEntryOption(icon: "character.circle.fill", notes: currentEntry.notes)
                                    }
                                }
                                .popover(isPresented: $showingNotePopover) {
                                    NoteView(entry: currentEntry, note: currentEntry.notes!)
                                    }
                                
                                Button{
                                    showingPicturePopover = true
                                }label: {
                                    if currentEntry.image! == "" {
                                    EntryOption(
                                        icon: "photo.circle.fill",
                                        optionTitle: "photo"
                                    )
                                } else {
                                    FilledEntryOption(icon: "photo.circle.fill", picture: currentEntry.image)
                                }
                                
                            }
                            .popover(isPresented: $showingPicturePopover) {
                                PictureView(entry: currentEntry)
                                }
                                
                            }

                        }  //SECTION OPTIONS

                        //SECTION SANTE
                        EntrySection(title: "Et ta santé dans l’histoire ?") {
                            VStack(spacing: 22) {
                                HealthSlider(
                                    entry: currentEntry,
                                    message: "Es-tu anxieux.se ?",
                                    healthLevels: anxietyValues,
                                    healthIcons: anxietyIcons,
                                    selectedLevel: $anxietyIndex
                                )
                                HealthSlider(
                                    entry: currentEntry,
                                    message: "Comment te sens-tu ?",
                                    healthLevels: energyValues,
                                    healthIcons: energyIcons,
                                    selectedLevel: $energyIndex
                                )
                                HealthSlider(
                                    entry: currentEntry,
                                    message: "As-tu de l’appétit?",
                                    healthLevels: appetiteValues,
                                    healthIcons: appetiteIcons,
                                    selectedLevel: $appetiteIndex
                                )
                                HealthSlider(
                                    entry: currentEntry,
                                    message: "Comment s’est passé ta nuit ?",
                                    healthLevels: sleepValues,
                                    healthIcons: sleepIcons,
                                    selectedLevel: $sleepIndex
                                )
                            }

                        }  //SECTION SANTE
                        .frame(alignment: .leading)

                        // CTA
                        Button {
                            currentEntry.date = date
                            
                            currentEntry.anxiety = AnxietyLevel.allCases[anxietyIndex]
                            currentEntry.energy = EnergyLevel.allCases[energyIndex]
                            currentEntry.appetite =
                                AppetiteLevel.allCases[appetiteIndex]
                            currentEntry.sleep = SleepLevel.allCases[sleepIndex]
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
        }.foregroundStyle(.text)
    }
}


#Preview {
    EcranNouvelleEntree(entry: UsersViewModel().connectedUser.entries[0]!, date: UsersViewModel().connectedUser.entries[0].date)
}
