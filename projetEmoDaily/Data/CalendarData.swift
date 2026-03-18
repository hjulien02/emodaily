//
//  CalendarData.swift
//  projetEmoDaily
//
//  Created by Apprenant155 on 11/03/2026.
//

import Foundation

struct CalendarData {

    //Calendrier local (format européen)
    static let calendar: Calendar = {
        var frenchCalendar = Calendar(identifier: .gregorian)
        frenchCalendar.locale = Locale(identifier: "fr_FR")
        return frenchCalendar
    }()

    ///////////////////////MOIS

    //Affichage du mois
    static func monthTitle(for date: Date, full: Bool = true) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        //format mois complet et l'année OU mois
        formatter.dateFormat = full ? "MMMM yyyy" : "MMMM"
        return formatter.string(from: date).capitalized
    }

    ///////////////////////SEMAINE

    //Jours de la semaine (court)
    static var weekdays: [String] {
        //Affiche les jours en plus court (ex: Lun)
        let symbols = calendar.shortStandaloneWeekdaySymbols
        //Passe le dimanche en dernier
        return Array(symbols[1...6] + [symbols[0]])
            //Enleve les points à chaque élément
            .map { $0.replacingOccurrences(of: ".", with: "").capitalized }
    }

    //Affichage de l'indice du jour de la semaine
    static var todayWeekdayIndex: Int {
        let originalIndex = calendar.component(.weekday, from: Date()) - 1
        return (originalIndex + 6) % 7
    }

    //Affiche le numéro de semaine
    static func weekNumber(from date: Date) -> Int {
        calendar.component(.weekOfYear, from: date)
    }

    //Creation d'un tableau de toutes les dates du mois
    //Ex: du 02 mars au 31 mars
    static func betweenDates(start: Date, end: Date) -> [Date] {
        var dates: [Date] = []
        var current = start
        while current <= end {
            dates.append(current)
            guard
                let next = calendar.date(byAdding: .day, value: 1, to: current)
            else { break }
            current = next
        }
        return dates
    }

    ///////////////////////SEMAINE ET MOIS

    //Affiche le mois en entier (avec les numéros)
    static func generatedMonthGrid(for displayedMonth: Date) -> [Date] {
        guard  //si une des valeurs est nil la fonction renvoie un tableau vide
            let monthInterval = calendar.dateInterval(
                of: .month,
                for: displayedMonth
            ),
            let firstWeek = calendar.dateInterval(
                of: .weekOfMonth,
                for: monthInterval.start
            )
        else {
            return []
        }

        //Dernier jour du mois
        let lastDayOfMonth = calendar.date(
            byAdding: .day,
            value: -1,
            to: monthInterval.end
        )!

        // Trouve la derniere semaine du mois
        let weekday = calendar.component(.weekday, from: lastDayOfMonth)
        let daysToAdd = 8 - weekday

        //Dernier dimanche a affiché dans la grille
        let lastSunday = calendar.date(
            byAdding: .day,
            value: daysToAdd,
            to: lastDayOfMonth
        )!

        return betweenDates(start: firstWeek.start, end: lastSunday)
    }

    static func generateMonth(for year: Int) -> [Date] {
        var months: [Date] = []
        for month in 1...12 {
            if let date = calendar.date(
                from: DateComponents(year: year, month: month)
            ) {
                months.append(date)
            }
        }
        return months
    }

}
