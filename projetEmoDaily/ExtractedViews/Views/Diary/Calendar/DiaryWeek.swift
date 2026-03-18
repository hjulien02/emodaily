//
//  DiaryWeek.swift
//  projetEmoDaily
//
//  Created by Apprenant155 on 13/03/2026.
//

import SwiftUI

struct DiaryWeek: View {

    @ObservedObject var vmDiary: DiaryViewModel

    let rows = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {

        VStack {

            // Header - Semaine
            WeekdayHeader(
                displayedDate: $vmDiary.displayedMonth,
                periodType: .weekOfYear
            )

            LazyHGrid(rows: rows) {

                // Affiche les jours de la semaine
                ForEach(CalendarData.weekdays.indices, id: \.self) {
                    index in
                    Text(CalendarData.weekdays[index])
                }

                // Affiche les jours du mois
                let days = CalendarData.generatedMonthGrid(
                    for: vmDiary.displayedMonth
                )

                ForEach(days, id: \.self) { day in

                    // Semaine actuelle
                    let isCurrentWeek = CalendarData.calendar.isDate(
                        day,
                        equalTo: vmDiary.displayedMonth,
                        toGranularity: .weekOfYear
                    )

                    // Date selectionnée
                    let isTodayDate = CalendarData.calendar.isDate(
                        vmDiary.selectedDate,
                        inSameDayAs: day
                    )

                    // Entrée de cette semaine
                    let entryForWeek = vmDiary.entriesList.first {
                        Calendar.current.isDate($0.date, inSameDayAs: day)
                    }

                    if isCurrentWeek {
                        HStack {
                            Text(
                                "\(CalendarData.calendar.component(.day, from: day))"
                            )
                            .fontWeight(isTodayDate ? .bold : .regular)
                            .padding(.leading, -5)
                            .padding(.trailing)

                            Button {
                                vmDiary.selectedEntry = entryForWeek
                            } label: {
                                if let entry = entryForWeek {
                                    HStack {
                                        Text(entry.emotion.getEmoji())

                                        if entry.notes != nil {
                                            Text(entry.notes ?? "")
                                                .foregroundStyle(.text)
                                        } else {
                                            Image(
                                                systemName:
                                                    "photo.circle.fill"
                                            )
                                            .foregroundStyle(.text)
                                        }
                                    }
                                    .padding()
                                }
                            }
                            .frame(width: 262, alignment: .leading)
                            .background(.green2)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        }///end HStack

                    }///end isCurrentWeek

                }///end ForEach
                
                    // Si contrôle de la modal avec une valeur optionnel => item
                    // Si données => ouvre la modal
                    .sheet(item: $vmDiary.selectedEntry) { entry in
                        EntryModal(entry: entry)
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    }

            }///end LazyHGrid
                .frame(height: 374)
        }
        .padding()
        .background(.green15)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

}

#Preview {
    DiaryWeek(vmDiary: DiaryViewModel())
}
