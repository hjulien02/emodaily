//
//  DiaryScreen.swift
//  projetEmoDaily
//
//  Created by Apprenant155 on 04/03/2026.
//

import SwiftUI

struct DiaryScreen: View {

    @State var selectedPeriod = "Mois"
    @State var period = ["Semaine", "Mois", "Année"]

    @StateObject private var vmDiary = DiaryViewModel()

    //Chargement de la page
    @State var isLoading = true

    var body: some View {

        NavigationStack {
            ZStack {

                Color.bg.ignoresSafeArea()

                VStack {
                    Title(title: "Journal")

                    //Affichage des periodes
                    HStack {
                        ForEach(period, id: \.self) { onePeriod in
                            PickerButton(
                                text: onePeriod,
                                selectedPicker: $selectedPeriod
                            )
                        }
                    }
                    .padding(.bottom, 10)

                    //Affichage du calendrier (par semaine, mois ou année)

                    //Chargement
                    if isLoading {
                        ProgressView("Chargement des données")
                            .tint(Color("text"))
                            .foregroundStyle(Color("text"))
                            .scaleEffect(1.1)
                            .frame(maxHeight: .infinity)
                    } else {

                        ScrollView {
                            if period[0].description == selectedPeriod {
                                DiaryWeek(vmDiary: vmDiary)
                            } else if period[1].description == selectedPeriod {
                                DiaryMonth(vmDiary: vmDiary)
                            } else {
                                DiaryYear(vmDiary: vmDiary)
                            }
                        }
                    }

                    //Ajout d'une entrée
                    NavigationLink("+", destination: NewEntryScreen())
                        .foregroundStyle(.white)
                        .bold()
                        .frame(width: 64, height: 64)
                        .background(.green4)
                        .clipShape(Circle())
                        .shadow(color: .white, radius: 10)

                }
                .padding()
            }
        }
        //Données
        .task {
            isLoading = true
            await vmDiary.loadData()
            isLoading = false
        }
    }
}

#Preview {
    DiaryScreen()
}
