//
//  EcranNouvelleEntree.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 04/03/2026.
//

import SwiftUI

struct NewEntryScreen: View {
    @Binding var vmEntries: EntriesViewModel
    @Binding var vmUser: UsersViewModel
    @Binding var entriesList: [Entry]

    @State var currentEntry: Entry

    var rows = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    @State var selectedEmotion: Emotion
    
    @State private var showingNotePopover = false
    @State var note: String = ""
    
    @State private var showingPicturePopover = false
    @State var image: [Attachment]?
    
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
                            selection: $currentEntry.date,
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
                        EntrySection(title: "Comment s’est passée ta journée ?")
                        {

                            GreenContainer {
                                LazyHGrid(rows: rows) {
                                    ForEach(Emotion.allCases, id: \.self) {
                                        thisEmotion in
                                        
                                        if thisEmotion != Emotion.allCases.last{
                                            EmotionButton(
                                                selectedEmotion: $selectedEmotion, emotion: thisEmotion,
                                                emotionText: thisEmotion.rawValue,
                                                emoji: thisEmotion.getEmoji())
                                        }

                                    }
                                }
                            }
                        }  //SECTION EMOTION

                        //SECTION OPTIONS
                        EntrySection(
                            title: "Quelque chose à raconter ?",
                            subtitle: "Seulement si tu le veux..."
                        ) {

                            LazyVGrid(columns: columns) {
                                Button {
                                    showingNotePopover = true
                                } label: {
                                    if note != ""
                                    {
                                        FilledEntryOption(
                                            icon: "character.circle.fill",
                                            notes: note
                                        )
                                    } else {
                                        EntryOption(
                                            icon: "character.circle.fill",
                                            optionTitle: "note"
                                        )
                                    }
                                }
                                .popover(isPresented: $showingNotePopover) {
                                    NoteView(
                                        entryNotes: $note, showingNotePopover: $showingNotePopover
                                    )
                                }

                                Button {
                                    showingPicturePopover = true
                                } label: {
                                    if image != nil {
                                        FilledEntryOption(
                                            icon: "photo.circle.fill",
                                            picture: image
                                        )
                                    } else {
                                        EntryOption(
                                            icon: "photo.circle.fill",
                                            optionTitle: "photo"
                                        )
                                    }

                                }
                                .popover(isPresented: $showingPicturePopover) {
                                    PictureView( entry: $currentEntry, showingPicturePopover: $showingPicturePopover, entryImage: $image)
                                }

                            }

                        }  //SECTION OPTIONS

                        //SECTION SANTE
                        EntrySection(title: "Et ta santé dans l’histoire ?") {
                            VStack(spacing: 22) {
                                HealthSlider(
                                    message: "Es-tu anxieux.se ?",
                                    healthLevels: anxietyValues,
                                    healthIcons: anxietyIcons,
                                    selectedLevel: $anxietyIndex
                                )
                                HealthSlider(
                                    message: "Comment te sens-tu ?",
                                    healthLevels: energyValues,
                                    healthIcons: energyIcons,
                                    selectedLevel: $energyIndex
                                )
                                HealthSlider(
                                    message: "As-tu de l’appétit?",
                                    healthLevels: appetiteValues,
                                    healthIcons: appetiteIcons,
                                    selectedLevel: $appetiteIndex
                                )
                                HealthSlider(
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
                            Task {
                                currentEntry.anxiety =
                                    AnxietyLevel.allCases[anxietyIndex]
                                currentEntry.energy =
                                    EnergyLevel.allCases[energyIndex]
                                currentEntry.appetite =
                                    AppetiteLevel.allCases[appetiteIndex]
                                currentEntry.sleep =
                                    SleepLevel.allCases[sleepIndex]
                                
                                do {
                                    let entry =
                                        try await vmEntries.createNewEntry(
                                            date: currentEntry.date,
                                            emotion: selectedEmotion,
                                            notes: note,
                                            image: image,
                                            anxiety: currentEntry.anxiety,
                                            energy: currentEntry.energy,
                                            appetite: currentEntry.appetite,
                                            sleep: currentEntry.sleep, user: [$vmUser.connectedUserID]
                                        )
                                    await MainActor.run {
                                                    var newList = entriesList
                                                    newList.append(entry)
                                                    entriesList = newList
                                                }
                                } catch {
                                    print(error)
                                }
                            }
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
            .task {
                do {
                    try await vmUser.fetchUsers()
                } catch {
                    print(error)
                }

            }
    }
}

#Preview {
        let sampleEntry = Entry(
//            id: 2,
            date: Date(),
            emotion: .unchosen,
            notes: "",
            image: nil,
            anxiety: .neutral,
            energy: .neutral,
            appetite: .neutral,
            sleep: .sleep,
            user: [""]
        )
        
        NewEntryScreen(
            vmEntries: .constant(EntriesViewModel()),
            vmUser: .constant(UsersViewModel()),
            entriesList: .constant([]),
            currentEntry: sampleEntry, selectedEmotion: sampleEntry.emotion, note: sampleEntry.notes!
        )
}

