//
//  MonthlyGrid.swift
//  projetEmoDaily
//
//  Created by Apprenant155 on 17/03/2026.
//

import SwiftUI

struct MonthlyGrid: View {

    @Binding var displayedMonth: Date
    @Binding var selectedDate: Date

    //Modal
    //Création d'une variable Entrée optionnel
    //Pour savoir qu'elle entrée ouvre la popup
    @Binding var selectedEntry: Entry?

    var entriesList: [Entry] = []

    let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        VStack {

            //Affiche le mois avec les nombres, et les entrées de l'utilisateur
            LazyVGrid(columns: columns) {

                let days = CalendarData.generatedMonthGrid(
                    for: displayedMonth
                )

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
                        Calendar.current.isDate(
                            $0.date,
                            inSameDayAs: day
                        )
                    }

                    VStack(spacing: 2) {

                        // Vérifie si une entrée existe pour ce jour et crée une constante
                        // Affiche les émojis en même temps que le mois en cours
                        if let entry = entryForMonth, isCurrentMonth {

                            Button {
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

                    //Si contrôle de la modal avec une valeur optionnel => item
                    //Si données => ouvre la modal, si nil n'ouvre pas la modal
                    .sheet(item: $selectedEntry) { entry in
                        EntryModal(entry: entry)
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    }

            }///end LazyVGrid
                .frame(height: 347)
        }///end VStack

    }
}

#Preview {
    MonthlyGrid(
        displayedMonth: .constant(Date()),
        selectedDate: .constant(Date.now),
        selectedEntry: .constant(nil)
    )
}
