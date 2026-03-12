//
//  WeekdayHeader.swift
//  projetEmoDaily
//
//  Created by Apprenant155 on 11/03/2026.
//

import SwiftUI

struct WeekdayHeader: View {

    @Binding var displayedDate: Date
    var component: Calendar.Component

    var titleCalendar: String {
        if component == .month {
            return CalendarData.monthText(from: displayedDate)
        } else {
            let weekNumber = CalendarData.weekNumber(from: displayedDate)
            return "Semaine \(weekNumber)"
        }
    }

    //Navigue entre les mois et les semaines
    func changeDate(by value: Int) {
        switch component {
        case .month:
            displayedDate =
                CalendarData.calendar.date(
                    byAdding: Calendar.Component.month,
                    value: value,
                    to: displayedDate
                ) ?? displayedDate
        case .weekOfYear:
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
    WeekdayHeader(displayedDate: .constant(Date.now), component: .month)
}
