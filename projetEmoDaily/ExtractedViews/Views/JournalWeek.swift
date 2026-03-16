//
//  JournalWeekView.swift
//  projetEmoDaily
//
//  Created by Apprenant155 on 13/03/2026.
//

import SwiftUI

struct JournalWeek: View {

    @State private var displayedMonth = Date()
    @State private var selectedDate = Date.now

    var indexToday = CalendarData.todayWeekdayIndex.description

    //Lien API Entry et User
    @State var vmEntries = EntriesViewModel()
    @State var vmUser = UsersViewModel()
    @State var entriesList: [Entry] = []

    let rows = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    @State private var showModal = false

    //Chargement de la page
    //@State var isLoading = true

    var body: some View {

        //        NavigationStack {

        VStack {

            //Header
            WeekdayHeader(
                displayedDate: $displayedMonth,
                component: .weekOfYear
            )

            LazyHGrid(rows: rows) {

                //                    if (isLoading) {
                //                        ProgressView("Chargement...")
                //                            .tint(Color("text"))
                //                            .foregroundStyle(Color("text"))
                //                            .scaleEffect(1.1)
                //                            .frame(maxHeight: .infinity)
                //                    } else {

                //Affiche les jours de la semaine
                ForEach(CalendarData.weekdays.indices, id: \.self) {
                    index in
                    Text(CalendarData.weekdays[index])
                        .fontWeight(
                            indexToday == index.description ? .bold : .regular
                        )
                }

                //Affiche les jours du mois
                let days = CalendarData.generatedMonthGrid(
                    for: displayedMonth
                )

                ForEach(days, id: \.self) { day in

                    //Semaine actuelle
                    let isCurrentWeek = CalendarData.calendar.isDate(
                        day,
                        equalTo: displayedMonth,
                        toGranularity: .weekOfYear
                    )

                    //Date selectionnée
                    let isTodayDate = CalendarData.calendar.isDate(
                        selectedDate,
                        inSameDayAs: day
                    )

                    //Entrée de cette semaine
                    let entryForWeek = entriesList.first {
                        Calendar.current.isDate($0.date, inSameDayAs: day)
                    }

                    if isCurrentWeek {
                        HStack {
                            Text(
                                "\(CalendarData.calendar.component(.day, from: day))"
                            )
                            .fontWeight(isTodayDate ? .bold : .regular)
                            .padding(.leading, -10)

                            Button {
                                showModal.toggle()
                            } label: {
                                if let entry = entryForWeek {
                                    HStack {
                                        Text(entry.emotion.getEmoji())

                                        //?? Opérateur remplacement de nil
                                        //Ternaire
                                        Text(entry.notes ?? "")
                                            .foregroundStyle(.text)

                                    }
                                    .padding()
                                    
                                    //Affiche les entrées sous forme de modal
                                    .sheet(isPresented: $showModal) {
//                                        EntryModal(dateEntry: entry.date, anxietyLevel: entry.anxiety, dismissModal: $showModal)
                                            //.presentationDetents([.medium, .large])
                                    }

                                }
                            }

                            .frame(width: 270)
                            .background(.green2)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        .frame(width: 300)
                    }///End isCurrentWeek

                }///End ForEach

                // }///End Loading

            }///End LazyHGrid
                .frame(height: 390)

                .task {
                    //isLoading = true
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
                    //isLoading = false
                }

        }
        .padding()
        .background(.green15)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    //}
}

#Preview {
    JournalWeek()
}
