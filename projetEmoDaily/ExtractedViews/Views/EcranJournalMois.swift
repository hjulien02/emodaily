//
//  EcranJournalMois.swift
//  projetEmoDaily
//
//  Created by Apprenant155 on 10/03/2026.
//

import SwiftUI

struct EcranJournalMois: View {

    @State var displayedMonth = Date()
    @State var selectedDate = Date.now
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack(spacing: 24) {

            //Change le texte du Header
            WeekdayHeader(displayedDate: $displayedMonth, component: .month)
            
            //Text(displayedMonth.description)

            //Affiche les jours de la semaine
            HStack {
                ForEach(CalendarData.weekdays.indices, id: \.self) { index in
                    Spacer()
                    Text(CalendarData.weekdays[index])
                        .fontWeight(
                            index == CalendarData.todayWeekdayIndex
                                ? .bold : .regular
                        )
                    Spacer()
                }
            }

            //Affiche le mois avec les nombres
            LazyVGrid(columns: columns){
                
                //Genere la grille des mois
                let days = CalendarData.generatedMonthGrid(for: displayedMonth)
                
                ForEach(days, id: \.self){ day in
                    
                    let isCurrentMonth = CalendarData.calendar.isDate(day, equalTo: displayedMonth, toGranularity: .month)
                    let isSelectedDate = CalendarData.calendar.isDate(selectedDate, inSameDayAs: day)
                    
                    VStack{
                        Text("\(CalendarData.calendar.component(.day, from: day))")
                            .foregroundStyle(isCurrentMonth ? .text : .gray)
                            .fontWeight(isSelectedDate ? .bold : .regular)
                            .frame(maxWidth: .infinity, minHeight: 30)
                        
                        Text(isCurrentMonth ? "😎" : "")
                                .background(.bg)
                                .clipShape(RoundedRectangle(cornerRadius: 20))

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
    EcranJournalMois()
}
