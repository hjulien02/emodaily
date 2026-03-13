//
//  EcranJournal.swift
//  projetEmoDaily
//
//  Created by Apprenant155 on 04/03/2026.
//

import SwiftUI

struct JournalView: View {

    @State var selectedPeriod = "Semaine"
    @State var period = ["Semaine", "Mois", "Année"]

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
                    ScrollView {
                        if period[0].description == selectedPeriod {
                            Text("Semaine")
                        } else if period[1].description == selectedPeriod {
                            JournalMonthView()
                        } else {
                            Text("Année")
                        }
                    }

                    //Ajout d'une entrée
                    NavigationLink("+", destination: EcranNouvelleEntree())
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
    }
}

#Preview {
    JournalView()
}
