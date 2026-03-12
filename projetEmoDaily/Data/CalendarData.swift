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

    //Formattage du mois et de l'année
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        //format mois complet et l'année
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()

    //Affichage du mois
    static func monthText(from date: Date) -> String {
        formatter.string(from: date).capitalized
    }

    
    ///////////////////////SEMAINE

    //Jours de la semaine (court)
    static var weekdays: [String] {
        //Affiche les jours en plus court
        let symbols = calendar.shortStandaloneWeekdaySymbols
        //Passe le dimanche en dernier
        return Array(symbols[1...6] + [symbols[0]])
            //Enleve les points
            .map { $0.replacingOccurrences(of: ".", with: "").capitalized }
    }

    //Affichage de l'indice du jour de la semaine
    static var todayWeekdayIndex: Int {
        let originalIndex = calendar.component(.weekday, from: Date()) - 1
        return (originalIndex + 6) % 7
    }
    
    //Creation d'un tableau de toutes les dates du mois
    //Ex: du 02 mars au 31 mars
    static func betweenDates(start: Date, end: Date) -> [Date] {
        var dates: [Date] = []
        var current = start
        while current <= end {
            dates.append(current)
            guard let next = calendar.date(byAdding: .day, value: 1, to: current)
            else { break }
            current = next
        }
        return dates
    }
    
    //Affiche le numéro de semaine
    static func weekNumber(from date: Date) -> Int {
        calendar.component(.weekOfYear, from: date)
    }
    
    
    ///////////////////////SEMAINE ET MOIS
    
    //Affiche le mois avec les nombres
    static func generatedMonthGrid(for displayedMonth: Date) -> [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: displayedMonth),
            let firstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
            let lastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end - 1)
        else {
            return []
        }
        return betweenDates(start: firstWeek.start, end: lastWeek.end)
    }
    
}
