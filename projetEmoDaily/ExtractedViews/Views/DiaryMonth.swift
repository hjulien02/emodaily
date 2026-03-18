//
//  DiaryMonth.swift
//  projetEmoDaily
//
//  Created by Apprenant155 on 10/03/2026.
//

import SwiftUI

struct DiaryMonth: View {

    //Recoit le VM depuis le parent DiaryScreen
    @ObservedObject var vmDiary: DiaryViewModel

    var body: some View {
        VStack {

            //Header - Mois
            WeekdayHeader(
                displayedDate: $vmDiary.displayedMonth,
                periodType: .month
            )

            //Affiche les jours de la semaine
            HStack {
                ForEach(CalendarData.weekdays.indices, id: \.self) { index in
                    Spacer()
                    Text(CalendarData.weekdays[index])
                    Spacer()
                }
            }

            VStack {

                //Affichage des entrées du mois en cours
                MonthlyGrid(
                    displayedMonth: $vmDiary.displayedMonth,
                    selectedDate: $vmDiary.selectedDate,
                    //Essaie de le passer en Binding alors que pas possible donc sans le $
                    selectedEntry: $vmDiary.selectedEntry,
                    entriesList: vmDiary.entriesList
                )
            }

        }
        .padding()
        .background(.green15)
        .clipShape(RoundedRectangle(cornerRadius: 20))

    }
}

#Preview {
    DiaryMonth(vmDiary: DiaryViewModel())
}
