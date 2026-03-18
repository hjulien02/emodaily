//
//  WeekdayHeader.swift
//  projetEmoDaily
//
//  Created by Apprenant155 on 11/03/2026.
//

import SwiftUI

struct WeekdayHeader: View {

    @Binding var displayedDate: Date
    let periodType: Calendar.Component

    var titleCalendar: String {
        switch periodType {
        case .month:
            return CalendarData.monthTitle(for: displayedDate)
        case .weekOfYear:
            let weekNumber = CalendarData.weekNumber(from: displayedDate)
            return "Semaine \(weekNumber)"
        case .year:
            let year = Calendar.current.component(.year, from: displayedDate)
            return "\(year)"
        default:
            return ""
        }
    }

    // Navigue entre les mois et les semaines
    func changeDate(by value: Int) {
        switch periodType {
        case .year:
            let currentYear = Calendar.current.component(
                .year,
                from: displayedDate
            )
            // Année suivante (année actuelle + 1)
            let newYear = currentYear + value

            // On met à jour displayedDate si newDate existe
            if let newDate = Calendar.current.date(
                from: DateComponents(year: newYear, month: 1, day: 1)
            ) {
                displayedDate = newDate
            }
            
        case .month:
            // Ajoute ou enlève un mois à la date actuelle
            // Si nil, on garde la date actuelle
            displayedDate =
                CalendarData.calendar.date(
                    byAdding: Calendar.Component.month,
                    value: value,
                    to: displayedDate
                ) ?? displayedDate
            
        case .weekOfYear:
            // Ajoute ou enlève une semaine (7 jours)
            // Si nil, on garde la date actuelle
            displayedDate =
                CalendarData.calendar.date(
                    byAdding: .day,
                    value: 7 * value,
                    to: displayedDate
                ) ?? displayedDate
        default:
            break
        }
    }

    var body: some View {
        VStack(spacing: 24) {

            HStack(alignment: .center) {
                Button {
                    changeDate(by: -1)
                } label: {
                    Image(systemName: "chevron.left")
                }
                .padding()

                Spacer()
                Text(titleCalendar)
                Spacer()

                Button {
                    changeDate(by: +1)
                } label: {
                    Image(systemName: "chevron.right")
                }
                .padding()
            }
            .foregroundStyle(.text)
            .bold()

        }
    }
}

#Preview {
    WeekdayHeader(displayedDate: .constant(Date.now), periodType: .weekOfYear)
}
