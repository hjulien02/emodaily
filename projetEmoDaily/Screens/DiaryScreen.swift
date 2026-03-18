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
    
    //Lien avec la VM DiaryViewModel
    @StateObject var vmDiary = DiaryViewModel()
    
    //Chargement de la page
    @State var isLoading = true
    
    func makeFakeEntry() -> Entry {
        return Entry(
            date: Date(),
            emotion: .unchosen,
            anxiety: .low,
            energy: .low,
            appetite: .low,
            sleep: .allnighter,
            user: [""]
        )
    }
    
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
                    
                    //Chargement
                    if isLoading {
                        ProgressView("Chargement des données")
                            .tint(Color("text"))
                            .foregroundStyle(Color("text"))
                            .scaleEffect(1.1)
                            .frame(maxHeight: .infinity)
                    } else {
                        
                        //Affichage du calendrier (par semaine, mois ou année)
                        VStack {
                            if period[0].description == selectedPeriod {
                                DiaryWeek(vmDiary: vmDiary)
                            } else if period[1].description == selectedPeriod {
                                DiaryMonth(vmDiary: vmDiary)
                            } else {
                                DiaryYear(vmDiary: vmDiary)
                            }
                        }
                    }
                    Spacer()
                    
                    //Ajout d'une entrée
                    NavigationLink("+") {
                        NewEntryScreen(vmEntries: $vmDiary.vmEntries, vmUser: $vmDiary.vmUser, entriesList: $vmDiary.entriesList, currentEntry: makeFakeEntry(), selectedEmotion: makeFakeEntry().emotion, note: makeFakeEntry().notes!)
                    }
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

