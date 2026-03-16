//
//  EcranJournalMois.swift
//  projetEmoDaily
//
//  Created by Apprenant155 on 10/03/2026.
//

import SwiftUI

struct JournalMonth: View {

    @State private var displayedMonth = Date()
    @State private var selectedDate = Date.now

    //Lien API Entry et User
    @State var vmEntries = EntriesViewModel()
    @State var vmUser = UsersViewModel()
    @State var entriesList: [Entry] = []

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var showModal = false
    //Création d'une variable Entrée optionnel
    //Pour savoir qu'elle entrée ouvre la popup
    @State private var selectedEntry: Entry? = nil

    var body: some View {
        VStack {

            //Header
            WeekdayHeader(displayedDate: $displayedMonth, component: .month)

            //Affiche les jours de la semaine
            HStack {
                ForEach(CalendarData.weekdays.indices, id: \.self) { index in
                    Spacer()
                    Text(CalendarData.weekdays[index])
                    Spacer()
                }
            }

            //Affiche le mois avec les nombres, et les entrées de l'utilisateur
            LazyVGrid(columns: columns) {

                let days = CalendarData.generatedMonthGrid(for: displayedMonth)

                ForEach(days, id: \.self) { day in

                    //Mois actuel
                    //Compare un jour avec un jour du mois actuel
                    let isCurrentMonth = CalendarData.calendar.isDate(
                        day,
                        equalTo: displayedMonth,
                        toGranularity: .month
                    )

                    //Date selectionnée
                    //Verifie que selectedDate est bien égal à day
                    let isTodayDate = CalendarData.calendar.isDate(
                        selectedDate,
                        inSameDayAs: day
                    )

                    //Parcours les entrées et cherche les jours qui ont la meme date que day
                    let entryForMonth = entriesList.first {
                        Calendar.current.isDate($0.date, inSameDayAs: day)
                    }

                    VStack(spacing: 2) {

                        // Vérifie si une entrée existe pour ce jour
                        // Crée une constante "entry" qui contient la valeur
                        //Affiche les émojis en même temps que le mois en cours
                        if let entry = entryForMonth, isCurrentMonth {
                            Button {
                                showModal.toggle()
                                selectedEntry = entry
                            } label: {
                                Text(entry.emotion.getEmoji())
                                    .font(.system(size: 25))
                                    .frame(height: 25)
                            }
                            
                        } else {
                            Circle()
                                .fill(isCurrentMonth ? .bg : .green15)
                                .frame(width: 30, height: 25)
                        }

                        //Numéro du jour
                        Text(
                            "\(CalendarData.calendar.component(.day, from: day))"
                        )
                        .font(.system(size: 16))
                        .foregroundStyle(isCurrentMonth ? .text : .gray)
                        .fontWeight(isTodayDate ? .bold : .regular)
                        .frame(maxWidth: .infinity, minHeight: 25)

                    }///end VStack
                }///end ForEach
                //Affiche les entrées sous forme de modal
                .sheet(isPresented: $showModal){
                    //if let entry = selectedEntry vérifie si selectedEntry n’est pas nil
                    //Si oui, Swift crée une nouvelle constante entry non optionnelle dans le bloc
                    if let entry = selectedEntry {
                        EntryModal(entry: Entry(
                            date: entry.date,
                            emotion: entry.emotion,
                            notes: entry.notes,
                            image: entry.image,
                            anxiety: entry.anxiety,
                            energy: entry.energy,
                            appetite: entry.appetite,
                            sleep: entry.sleep
                        ), dismissModal: $showModal)
                    }
                }
            }///end LazyVGrid
            .task {
                do {
                    try await vmUser.fetchUsers()
                } catch {
                    print(error)
                }
                if let entries = vmUser.connectedUser.entries {
                    for entryId in entries {
                        do {
                            let entry =
                                try await vmEntries.fetchEntryByID(
                                    id: entryId
                                )
                            entriesList.append(entry)
                        } catch {
                            print(error)
                        }
                    }
                }
            }

        }
        .padding()
        .background(.green15)
        .clipShape(RoundedRectangle(cornerRadius: 20))

    }
}

#Preview {
    JournalMonth()
}
