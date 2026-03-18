//
//  DiaryYear.swift
//  projetEmoDaily
//
//  Created by Apprenant155 on 17/03/2026.
//

import SwiftUI

struct DiaryYear: View {

    @ObservedObject var vmDiary: DiaryViewModel

    // Extraction du mois et de l'année
    func startOfMonth(from date: Date) -> Date {
        let components = Calendar.current.dateComponents(
            [.year, .month],
            from: date
        )
        return Calendar.current.date(from: components)!
    }

    var body: some View {

        VStack {

            // Header
            WeekdayHeader(
                displayedDate: $vmDiary.displayedMonth,
                periodType: .year
            )

            // Affiche les jours de la semaine
            HStack {
                ForEach(CalendarData.weekdays.indices, id: \.self) { index in
                    Spacer()
                    Text(CalendarData.weekdays[index])
                    Spacer()
                }
            }

            // Affiche le mois actuel en premier
            ScrollViewReader { proxy in
                ScrollView {

                    VStack {
                        ForEach(
                            // Génère les 12 mois de l'année
                            CalendarData.generateMonth(
                                for: Calendar.current.component(
                                    .year,
                                    from: vmDiary.displayedMonth
                                )
                            ),
                            id: \.self
                        ) {
                            month in

                            // Filtre les entrées du mois courant
                            let entriesForMonth = vmDiary.entriesList.filter {
                                Calendar.current.isDate(
                                    $0.date,
                                    equalTo: month,
                                    toGranularity: .month
                                )
                            }

                            VStack(alignment: .leading) {
                                // Affichage du mois (sans l'année)
                                Text(
                                    CalendarData.monthTitle(
                                        for: month,
                                        full: false
                                    )
                                )
                                .bold()

                                // Affichage des mois avec les données
                                MonthlyGrid(
                                    displayedMonth: .constant(month),
                                    selectedDate: $vmDiary.selectedDate,
                                    selectedEntry: $vmDiary.selectedEntry,
                                    entriesList: entriesForMonth
                                )
                                // id pour le scroll
                                .id(month)
                            }
                            .padding(.vertical)
                        }
                    }

                    // Scroll automatique vers le mois actuel
                    // Remet à Janvier au clic de l'année suivante
                    .task(id: vmDiary.displayedMonth) {
                        proxy.scrollTo(
                            startOfMonth(from: vmDiary.displayedMonth),
                            anchor: .top
                        )
                    }

                }///end ScrollView
                .scrollIndicators(.hidden)

            }///end ScrollViewReader

        }
        .frame(height: 434)
        .padding()
        .background(.green15)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    DiaryYear(vmDiary: DiaryViewModel())
}
